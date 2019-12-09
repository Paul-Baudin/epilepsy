
%% Setting parameters

function [config] = hspike_setparams(config)

disp('setting parameters');

muscale = 50; % multiunit scale

if ismac
    error('Platform not supported')
elseif isunix
    rootpath_analysis   = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh';
    rootpath_data       = '/network/lustre/iss01/epimicro/patients/raw';
    os                  = 'unix'; 
elseif ispc
    rootpath_analysis	= '\\lexport\iss01.charpier\analyses\stephen.whitmarsh';
    rootpath_data       = '\\lexport\iss01.epimicro\patients\raw';
    os                  = 'windows';
else
    error('Platform not supported')
end

% Patient 1, perivetricular heterotopia #1
config{1}.os                        = os;
config{1}.name                      = { 'Hspike'};
config{1}.prefix                    = 'P1-'; % edit in code
config{1}.muse.startend             = { 'Hspike','Hspike'};   % start and end Muse marker
config{1}.patientdir                = fullfile(rootpath_data,       'pat_02711_1193');
config{1}.rawdir                    = fullfile(rootpath_data,       'pat_02711_1193', 'eeg');
config{1}.datasavedir               = fullfile(rootpath_analysis,   'data',   'hspike');         % where to write data
config{1}.imagesavedir              = fullfile(rootpath_analysis,   'images', 'hspike');       % where to print images

% config{1}.directory_searchstring    = '02711_2019-04-*';
config{1}.directorylist{1}          =  {'02711_2019-04-17_12-29',...
                                        '02711_2019-04-17_14-29',...
                                        '02711_2019-04-17_16-29',...
                                        '02711_2019-04-17_18-29',...
                                        '02711_2019-04-17_20-29',...
                                        '02711_2019-04-17_22-29',...
                                        '02711_2019-04-18_00-29',...
                                        '02711_2019-04-18_02-29',...
                                        '02711_2019-04-18_04-29',...
                                        '02711_2019-04-18_06-29',...
                                        '02711_2019-04-18_08-29',...
                                        '02711_2019-04-18_10-29',...
                                        '02711_2019-04-18_11-04'};        
config{1}.directorylist{2}          =  {'02711_2019-04-18_13-04',...
                                        '02711_2019-04-18_15-04',...
                                        '02711_2019-04-18_17-04',...
                                        '02711_2019-04-18_19-04',...
                                        '02711_2019-04-18_21-04',...
                                        '02711_2019-04-18_23-04',...
                                        '02711_2019-04-19_01-04',...
                                        '02711_2019-04-19_03-04',...
                                        '02711_2019-04-19_05-04',...
                                        '02711_2019-04-19_07-04',...
                                        '02711_2019-04-19_09-04',...
                                        '02711_2019-04-19_10-00',...
                                        '02711_2019-04-19_12-00'};        
config{1}.directorylist{3}          =  {'02711_2019-04-19_14-00',...
                                        '02711_2019-04-19_16-00',...
                                        '02711_2019-04-19_18-00',...
                                        '02711_2019-04-19_20-00',...
                                        '02711_2019-04-19_22-00',...
                                        '02711_2019-04-20_00-00',...
                                        '02711_2019-04-20_02-00',...
                                        '02711_2019-04-20_04-00',...
                                        '02711_2019-04-20_06-00',...
                                        '02711_2019-04-20_08-00',...
                                        '02711_2019-04-20_10-00',...
                                        '02711_2019-04-20_12-00'};        
                                                                   
config{1}.labels.micro              = {'mHaT2_1','mHaT2_3','mHaT2_4','mHaT2_6','mHaT2_8'};
config{1}.labels.macro              = {'_HaT2_1','_HaT2_2'};

config{1}.hyp.imagesavedir          = fullfile(rootpath_analysis, 'images', 'hspike'); 
config{1}.hyp.backupdir             = fullfile(rootpath_analysis, 'markerbackup');
config{1}.hyp.markerdir             = fullfile(rootpath_analysis, 'data',   'hspike');
config{1}.hyp.micromedchannel       = 'F3p6';
config{1}.hyp.contains              = {'NO_SCORE','AWAKE','PHASE_1','PHASE_2','PHASE_3','REM'}; % in order of height in plot
config{1}.hyp.markers               = {'Hspike','BAD'};
config{1}.hyp.markers               = {'Hspike'};
config{1}.hyp.overwrite             = 'append'; % 'append' or 'overwrite'
% config{1}.hyp.notcontains           = {"ADStartLoss","ADEndLoss","TTL","StartRecord","StopRecord","NLXEvent","BAD"};

config{1}.align.name                = {'Hspike'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{1}.align.channel             = {'_HaT2_1'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{1}.align.abs                 = {'no'};
config{1}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{1}.align.filter              = {'bp'};
config{1}.align.freq                = {[1, 20]};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{1}.align.hilbert             = {'no'};
config{1}.align.thresh              = [0];
config{1}.align.toiplot{1}          = [-0.3,  1.7];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{1}.align.toiactive{1}        = [-0.1,  0.3];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{1}.align.toibaseline{1}      = [-0.3, -0.1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];

config{1}.LFP.hpfilter              = 'no';
config{1}.LFP.hpfreq                = 1;
config{1}.LFP.resamplefs            = 1000;
config{1}.LFP.baseline              = 'yes';
config{1}.LFP.baselinewindow{1}     = [-2, -1];
config{1}.LFP.slidestep             = [0.01];

config{1}.epoch.toi{1}              = [-0.1  0.5];                                                                
config{1}.epoch.pad                 = [0.5, 0.5, 0.5];

config{1}.circus.channel            = {'mHaT2_1','mHaT2_3','mHaT2_4','mHaT2_6','mHaT2_8'};
config{1}.circus.reref              = 'yes';
config{1}.circus.refchan            = 'mHaT2_2';
config{1}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'hspike', 'SpykingCircus');
config{1}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{1}.circus.hpfreq             = 0; % even when not using

config{1}.spike.slidestep           = [0.001];
config{1}.spike.toispikerate{1}     = [-2, 1];         % for plotting spikerate
config{1}.spike.resamplefs          = 1000;
config{1}.spike.width               = 15;

config{1}.stats.bltoi{1}            = [-2,    -1];
config{1}.stats.alpha               = 0.025;

end
