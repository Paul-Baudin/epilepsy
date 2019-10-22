function [dat_micro, dat_macro] = readLFP(cfg,MuseStruct_micro,MuseStruct_macro,force,savedat)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [dat_micro, dat_macro] = readLFP(cfg,MuseStruct_micro,MuseStruct_macro,force,savedat)
%
% Reads data from macro and micro electrodes, epoched according to markers extracted from Muse,
% and downsamples to same samplerate.
%
% Necessary fields:





% Note:
% Names of markers that contain a space (' ') or minus ('-') will be
% replaced by an underscore ('_').
%
% Dependencies: writeMuseMarkers.m, dir2.m, recent FieldTrip version
%
% (c) Stephen Whitmarsh (stephen.whitmarsh@gmail.com)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




fname = fullfile(cfg.datasavedir,[cfg.prefix,'data_aligned.mat']);

if exist(fname,'file') && force == false
    fprintf('************************************\n');
    fprintf('*** Loading precomputed LFP data ***\n');
    fprintf('************************************\n\n');
    
    load(fname,'dat_micro','dat_macro');
    
else
    fprintf('********************************\n');
    fprintf('*** (re-) computing LFP data ***\n');
    fprintf('********************************\n\n');
    
    
    % select those markers to load
    markerlist = [];
    for i = 1 : size(cfg.name,2)
        if ismember(cfg.name{i},cfg.name)
            markerlist = [markerlist, i];
        end
    end
    
    for imarker = markerlist
        
        hasmarker_micro = zeros(length(MuseStruct_micro),1);
        hasmarker_macro = zeros(length(MuseStruct_macro),1);
                   
        for idir = 1:length(MuseStruct_micro{ipart})
            if isfield(MuseStruct_micro{idir},'markers')
                if isfield(MuseStruct_micro{idir}.markers,(cfg.muse.startend{imarker,1}))
                    if ~isempty(MuseStruct_micro{idir}.markers.(cfg.muse.startend{imarker,1}).events)
                        
                        % select MICRO files
                        micro_filenrs = [];
                        for ifile = 1 : size(MuseStruct_micro{idir}.filenames,2)
                            for ilabel = 1 : size(cfg.labels.micro,2)
                                if ~isempty(strfind(MuseStruct_micro{idir}.filenames{ifile},cfg.labels.micro{ilabel}))
                                    micro_filenrs       = [micro_filenrs, ifile];
                                    microlabel{ifile}   = cfg.labels.micro{ilabel};
                                end
                            end
                        end
                        
                        % select MACRO files
                        macro_filenrs = [];
                        for ifile = 1 : size(MuseStruct_macro{idir}.filenames,2)
                            for ilabel = 1 : size(cfg.labels.macro,2)
                                if ~isempty(strfind(MuseStruct_macro{idir}.filenames{ifile},cfg.labels.macro{ilabel}))
                                    macro_filenrs       = [macro_filenrs, ifile];
                                    macrolabel{ifile}   = cfg.labels.macro{ilabel};
                                end
                            end
                        end
                        
                        % load trials for selected MICRO channels
                        for ifile = micro_filenrs
                            
                            cfgtemp = [];
                            cfgtemp.dataset         = fullfile(MuseStruct_micro{idir}.directory, MuseStruct_micro{idir}.filenames{ifile});
                            cfgtemp.hpfilter        = cfg.LFP.hpfilter;
                            cfgtemp.hpfreq          = cfg.LFP.hpfreq;
                            temp                    = ft_preprocessing(cfgtemp);
                            
                            % create Fieldtrip trl
                            hdr_micro               = ft_read_header(fullfile(MuseStruct_micro{idir}.directory,MuseStruct_micro{idir}.filenames{ifile}));
                            Startsample             = [];
                            Endsample               = [];
                            Stage                   = [];
                            trialnr                 = [];
                            
                            for ievent = 1 : size(MuseStruct_micro{idir}.markers.(cfg.muse.startend{imarker,1}).events,2)
                                Startsample(ievent) = MuseStruct_micro{idir}.markers.(cfg.muse.startend{imarker,1}).offset(ievent) + cfg.epoch.toi{imarker}(1) * hdr_micro.Fs - cfg.epoch.pad(imarker) * hdr_micro.Fs;
                                Endsample(ievent)   = MuseStruct_micro{idir}.markers.(cfg.muse.startend{imarker,2}).offset(ievent) + cfg.epoch.toi{imarker}(2) * hdr_micro.Fs + cfg.epoch.pad(imarker) * hdr_micro.Fs;
                                trialnr(ievent)     = ievent;
                                Stage(ievent)       = -1;
                                
                                % find overlap with hypnogram markers
                                for hyplabel = {'PHASE_1','PHASE_2','PHASE_3','REM','AWAKE','NO_SCORE'}
                                    if isfield(MuseStruct_micro{idir}.markers,[cell2mat(hyplabel),'__START__'])
                                        for i = 1 : size(MuseStruct_micro{idir}.markers.([cell2mat(hyplabel),'__START__']).events,2)
                                            x1 = MuseStruct_micro{idir}.markers.(cfg.muse.startend{imarker,1}).offset(ievent);
                                            x2 = MuseStruct_micro{idir}.markers.(cfg.muse.startend{imarker,2}).offset(ievent);
                                            y1 = MuseStruct_micro{idir}.markers.([cell2mat(hyplabel),'__START__']).offset(i);
                                            y2 = MuseStruct_micro{idir}.markers.([cell2mat(hyplabel),'__END__']).offset(i);
                                            if (y1 < x1) && (x1 < y2)
                                                %                                             if intersect(x1:x2,y1:y2)
                                                fprintf('Found "%s" overlapping with "%s" : adding to trialinfo: ',cfg.name{imarker},cell2mat(hyplabel));
                                                switch cell2mat(hyplabel)
                                                    case 'PHASE_1'
                                                        fprintf('%d\n',1);
                                                        Stage(ievent) = 1;
                                                    case 'PHASE_2'
                                                        fprintf('%d\n',2);
                                                        Stage(ievent) = 2;
                                                    case 'PHASE_3'
                                                        fprintf('%d\n',3);
                                                        Stage(ievent) = 3;
                                                    case 'REM'
                                                        fprintf('%d\n',4);
                                                        Stage(ievent) = 4;
                                                    case 'AWAKE'
                                                        fprintf('%d\n',0);
                                                        Stage(ievent) = 0;
                                                    case 'NO_SCORE'
                                                        fprintf('%d\n',0);
                                                        Stage(ievent) = 0;
                                                    otherwise
                                                        error('Unexpected label name in Hypnogram\n');
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            
                            Offset                          = ones(size(Endsample)) * (cfg.epoch.toi{imarker}(1) - cfg.epoch.pad(imarker)) * hdr_micro.Fs;
                            cfgtemp                         = [];
                            cfgtemp.trl                     = round([Startsample; Endsample; Offset]');
                            cfgtemp.trl(:,4)                = 1:size(cfgtemp.trl,1); % try to find trials that are missing aftewards
                            cfgtemp.trl(:,5)                = trialnr; % try to find trials that are missing aftewards
                            cfgtemp.trl(:,6)                = idir; % try to find trials that are missing aftewards
                            cfgtemp.trl(:,7)                = Stage; % add hypnogram stage
                            cfgtemp.trl                     = cfgtemp.trl(Startsample > 0 & Endsample < hdr_micro.nSamples,:); % so not to read before BOF or after EOFs
                            
                            cfgtemp.dataset                 = fullfile(MuseStruct_micro{idir}.directory, MuseStruct_micro{idir}.filenames{ifile});
                            filedat_micro{ifile}            = ft_redefinetrial(cfgtemp,temp);
                            clear temp
                            
                            % downsample data and correct baseline
                            cfgtemp                         = [];
                            cfgtemp.resamplefs              = cfg.LFP.resamplefs;
                            if strcmp(cfg.LFP.baseline,'no')
                                cfgtemp.demean              = 'no';
                            else
                                cfgtemp.demean              = 'yes';
                                cfgtemp.baselinewindow      = cfg.LFP.baselinewindow{imarker};
                            end
                            filedat_micro{ifile}            = ft_resampledata(cfgtemp,filedat_micro{ifile});
                            
                            % label to make them equal over files
                            filedat_micro{ifile}.label{1}   = microlabel{ifile};
                            
                            % flag for averaging
                            hasmarker_micro(idir) = 1;
                            
                        end
                        
                        % load trials for selected MACRO channels
                        for ifile = macro_filenrs
                            
                            cfgtemp = [];
                            cfgtemp.dataset                 = fullfile(MuseStruct_macro{idir}.directory, MuseStruct_macro{idir}.filenames{ifile});
                            temp                            = ft_preprocessing(cfgtemp);
                            if strcmp(cfg.LFP.hpfilter,'yes')
                                fprintf('Filtering macrodata %d of %d, this can take a while...',idir,length(MuseStruct_macro));
                                temp.trial{1}               = bandpassFilter(temp.trial{1},temp.fsample,cfg.LFP.hpfreq,cfg.LFP.resamplefs);
                            end
                            
                            % create Fieldtrip trl
                            hdr_macro               = ft_read_header(fullfile(MuseStruct_macro{idir}.directory,MuseStruct_macro{idir}.filenames{ifile}));
                            Startsample             = [];
                            Endsample               = [];
                            Stage                   = [];
                            trialnr                 = [];
                            
                            for ievent = 1 : size(MuseStruct_macro{idir}.markers.(cfg.muse.startend{imarker,1}).events,2)
                                Startsample(ievent) = MuseStruct_macro{idir}.markers.(cfg.muse.startend{imarker,1}).offset(ievent) + cfg.epoch.toi{imarker}(1) * hdr_macro.Fs - cfg.epoch.pad(imarker) * hdr_macro.Fs;
                                Endsample(ievent)   = MuseStruct_macro{idir}.markers.(cfg.muse.startend{imarker,2}).offset(ievent) + cfg.epoch.toi{imarker}(2) * hdr_macro.Fs + cfg.epoch.pad(imarker) * hdr_macro.Fs;
                                trialnr(ievent)     = ievent;
                                Stage(ievent)       = -1;
                                
                                % find overlap with hypnogram markers
                                for hyplabel = {'PHASE_1','PHASE_2','PHASE_3','REM','AWAKE','NO_SCORE'}
                                    if isfield(MuseStruct_macro{idir}.markers,[cell2mat(hyplabel),'__START__'])
                                        for i = 1 : size(MuseStruct_macro{idir}.markers.([cell2mat(hyplabel),'__START__']).events,2)
                                            x1 = MuseStruct_macro{idir}.markers.(cfg.muse.startend{imarker,1}).offset(ievent);
                                            x2 = MuseStruct_macro{idir}.markers.(cfg.muse.startend{imarker,2}).offset(ievent);
                                            y1 = MuseStruct_macro{idir}.markers.([cell2mat(hyplabel),'__START__']).offset(i);
                                            y2 = MuseStruct_macro{idir}.markers.([cell2mat(hyplabel),'__END__']).offset(i);
                                            
                                            %                                             if intersect(x1:x2,y1:y2)
                                            if (y1 < x1) && (x1 < y2)
                                                
                                                fprintf('Found "%s" overlapping with "%s" : adding to trialinfo: ',cfg.name{imarker},cell2mat(hyplabel));
                                                switch cell2mat(hyplabel)
                                                    case 'PHASE_1'
                                                        fprintf('%d\n',1);
                                                        Stage(ievent) = 1;
                                                    case 'PHASE_2'
                                                        fprintf('%d\n',2);
                                                        Stage(ievent) = 2;
                                                    case 'PHASE_3'
                                                        fprintf('%d\n',3);
                                                        Stage(ievent) = 3;
                                                    case 'REM'
                                                        fprintf('%d\n',4);
                                                        Stage(ievent) = 4;
                                                    case 'AWAKE'
                                                        fprintf('%d\n',0);
                                                        Stage(ievent) = 0;
                                                    case 'NO_SCORE'
                                                        fprintf('%d\n',0);
                                                        Stage(ievent) = 0;
                                                    otherwise
                                                        error('Unexpected label name in Hypnogram\n');
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                                
                            Offset                          = ones(size(Endsample)) * (cfg.epoch.toi{imarker}(1) - cfg.epoch.pad(imarker)) * hdr_macro.Fs;
                            cfgtemp                         = [];
                            cfgtemp.trl                     = round([Startsample; Endsample; Offset]');
                            cfgtemp.trl(:,4)                = 1:size(cfgtemp.trl,1); % try to find trials that are missing aftewards
                            cfgtemp.trl(:,5)                = trialnr; % try to find trials that are missing aftewards
                            cfgtemp.trl(:,6)                = idir; % try to find trials that are missing aftewards
                            cfgtemp.trl(:,7)                = Stage; % add hypnogram stage
                            cfgtemp.trl                     = cfgtemp.trl(Startsample > 0 & Endsample < hdr_macro.nSamples,:); % so not to read before BOF or after EOFs
                            
                            cfgtemp.dataset                 = fullfile(MuseStruct_macro{idir}.directory, MuseStruct_macro{idir}.filenames{ifile});
                            filedat_macro{ifile}            = ft_redefinetrial(cfgtemp,temp);
                            clear temp
                            
                            % downsample data and correct baseline
                            cfgtemp                         = [];
                            cfgtemp.resamplefs              = cfg.LFP.resamplefs;
                            if strcmp(cfg.LFP.baseline,'no')
                                cfgtemp.demean              = 'no';
                            else
                                cfgtemp.demean              = 'yes';
                                cfgtemp.baselinewindow      = cfg.LFP.baselinewindow{imarker};
                            end
                            filedat_macro{ifile}            = ft_resampledata(cfgtemp,filedat_macro{ifile});
                            
                            % truncate label to make them equal over files
                            filedat_macro{ifile}.label{1}   = macrolabel{ifile};
                            
                            % flag for averaging
                            hasmarker_macro(idir) = 1;
                            
                        end
                        
                        % concatinate channels, separately for MICRO/MACRO
                        cfgtemp                             = [];
                        cfgtemp.keepsampleinfo              = 'no';
                        dirdat_micro{idir}                  = ft_appenddata(cfgtemp,filedat_micro{micro_filenrs});
                        dirdat_macro{idir}                  = ft_appenddata(cfgtemp,filedat_macro{macro_filenrs});
                        clear filedat*
                    end
                end
            end
        end % idir
        
        % concatinate data over trials
        dat_macro{ipart}{imarker} = ft_appenddata([],dirdat_macro{find(hasmarker_macro)});
        dat_micro{ipart}{imarker} = ft_appenddata([],dirdat_micro{find(hasmarker_micro)});
        
        % add samplerate
        dat_micro{ipart}{imarker}.fsample = cfg.LFP.resamplefs;
        dat_macro{ipart}{imarker}.fsample = cfg.LFP.resamplefs;
        
        clear dirdat*
        
    end % imarker
end

if savedat
    save(fname,'dat_micro','dat_macro','-v7.3');
end
