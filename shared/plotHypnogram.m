function plotHypnogram(config,MuseStruct)

% loop over different parts, i.e. lists of directories
for ipart = 1 : size(MuseStruct,2)
    
    % remove empty structs
    MuseStruct{ipart} = MuseStruct{ipart}(~cellfun('isempty',MuseStruct{ipart}));
    
    % will first append all markers over directories
    MuseStruct_append{ipart}            = []; 
    MuseStruct_append{ipart}.markers    = [];
    
    % loop over directories
    for idir = 1 : size(MuseStruct{ipart},2)
        fprintf('Working on directory %d of %d\n',idir,size(MuseStruct{ipart},2));
        try % some might be empty
            mrknames = fieldnames(MuseStruct{ipart}{idir}.markers);
            for imarker = 1 : numel(mrknames)
                
                % if marker field doesn't exist yet, create it
                if ~isfield(MuseStruct_append{ipart}.markers,(mrknames{imarker}))
                    MuseStruct_append{ipart}.markers.(mrknames{imarker}) = MuseStruct{ipart}{idir}.markers.(mrknames{imarker});
                end
                
                % if marker.clock field doesn't exist yet, create it                
                if ~isfield(MuseStruct_append{ipart}.markers.(mrknames{imarker}),'clock')
                    MuseStruct_append{ipart}.markers.(mrknames{imarker}).clock = [];
                end
                
                % append clock field
                if isfield(MuseStruct{ipart}{idir}.markers.(mrknames{imarker}),'clock')
                    MuseStruct_append{ipart}.markers.(mrknames{imarker}).clock = ...
                        [MuseStruct_append{ipart}.markers.(mrknames{imarker}).clock, ...
                        MuseStruct{ipart}{idir}.markers.(mrknames{imarker}).clock];
                end          
                
            end
        catch
        end
    end
    
    % remove empty markers
    fn = fieldnames(MuseStruct_append{ipart}.markers);
    for imarker = 1 : numel(fn)
        if ~isfield(MuseStruct_append{ipart}.markers.(fn{imarker}),'clock')
            MuseStruct_append{ipart}.markers = rmfield(MuseStruct_append{ipart}.markers,fn{imarker});
        else
            if isempty(MuseStruct_append{ipart}.markers.(fn{imarker}).clock)
                MuseStruct_append{ipart}.markers = rmfield(MuseStruct_append{ipart}.markers,fn{imarker});             
            end
        end
    end
    
    % concatinate markers
    fn = fieldnames(MuseStruct_append{ipart}.markers);
    markerlabel = [];
    starttime = [];
    startsample = [];
    for imarker = 1 : numel(fn)
        markerlabel     = [markerlabel;     repmat(convertCharsToStrings(fn{imarker}),numel(MuseStruct_append{ipart}.markers.(fn{imarker}).clock),1)];
        starttime       = [starttime;       MuseStruct_append{ipart}.markers.(fn{imarker}).clock'];
    end
    
    endtime = starttime; % same time if cant find end marker (below)
    
    t = table(markerlabel,starttime,endtime);
    t = unique(t,'rows');
    t = sortrows(t,2);
        
    % find corresponding end-times of markers; code could be improved 
    i = 1;
    while i < height(t)
        if contains(t.markerlabel(i),'__START__')
            t.markerlabel(i)    = t.markerlabel{i}(1:end-9);
            endsindx            = find(contains(t.markerlabel,strcat(t.markerlabel{i},'__END__')));
            endsindx            = endsindx(endsindx > i);
            endindx             = endsindx(1);
            t.endtime(i)        = t.starttime(endindx);
            t(endindx,:)        = [];
        end
        i = i + 1;
    end
    
    % select hypnogram labels to plot
    hyp_tbl = t(contains(t.markerlabel,config.hyp.contains),:);
    mrk_tbl = t(contains(t.markerlabel,config.hyp.markers),:);
    
    % alternative selection of start/end of hypnogram
    % startsindx = find(contains(t.markerlabel,'CriseStart'));
    % endsindx   = find(contains(t.markerlabel,'CriseEnd'));
    % startsindx = find(contains(t.markerlabel,config.pattern.startmarker));
    % endsindx   = find(contains(t.markerlabel,config.pattern.endmarker));
    % fprintf('\n%d Patterns found\n',numel(startsindx));
    
    % segment into patterns/seizures/hypnograms,
    % if there is more than 4 hours in between them
    hyp_startsindx          = [1; find(diff(hyp_tbl.endtime) > hours(4))+1];
    hyp_endsindx            = [find(diff(hyp_tbl.endtime) > hours(4)); height(hyp_tbl)];
    
    % select markers that occur within hypnogram
    for i = 1 : numel(hyp_startsindx)
        hyp_night{i}        = hyp_tbl(hyp_startsindx(i)+1:hyp_endsindx(i)-1,:);
        hyp_starttime(i)    = hyp_tbl.starttime(hyp_startsindx(i));
        hyp_endtime(i)      = hyp_tbl.starttime(hyp_endsindx(i));
        mrk_night{i}        = mrk_tbl(mrk_tbl.starttime >= hyp_starttime(i) & mrk_tbl.endtime <= hyp_endtime(i),:);
    end
    maxlength               = max(hyp_endtime - hyp_starttime);
    
    %% plotting
    
    % create colortable for labels with colors that are maximally different
    colortable.label = unique(mrk_tbl.markerlabel);
    colortable.color = linspecer(numel(unique(mrk_tbl.markerlabel)));
    
    h = figure;
    for nighti = 1 : size(hyp_night,2)
        
        subplot(size(hyp_night,2)+1,1,nighti); hold;
        
        % create empty space to fit all
        fill([hyp_night{nighti}.starttime(1), hyp_starttime(nighti) + maxlength, hyp_starttime(nighti) + maxlength, hyp_night{nighti}.starttime(1)],[0 0 1 1],[1 1 1],'EdgeColor',[1 1 1]);
        X = [];
        Y = [];
        
        for im = 1 : height(mrk_night{nighti})
            c = colortable.color(strcmp(colortable.label,mrk_night{nighti}.markerlabel(im)),:);
            fill([mrk_night{nighti}.starttime(im), mrk_night{nighti}.endtime(im), mrk_night{nighti}.endtime(im), mrk_night{nighti}.starttime(im)],[0 0 1 1],c,'EdgeColor',c,'facealpha',1);
        end
        
        for im = 1 : height(hyp_night{nighti})
            if ~isempty(X)
                
                % if there's a gap, 'fill' with 0
                if hyp_night{nighti}.starttime(im) ~= X(end)
                    X = [X, X(end) hyp_night{nighti}.starttime(im)];
                    Y = [Y, 0,  0];
                end
            end
            X = [X, hyp_night{nighti}.starttime(im), hyp_night{nighti}.endtime(im)];
            
            % height in hypnogram is based on order of config.hyp.contains
            y = find(contains(config.hyp.contains,hyp_night{nighti}.markerlabel(im)));
            Y = [Y, y, y];
        end
        
        for i = 1 : length(X)-1
            if Y(i) ~= 0 && Y(i+1) ~= 0
                if strcmp(config.hyp.contains(Y(i)),'REM') && strcmp(config.hyp.contains(Y(i+1)),'REM')
                    plot([X(i) X(i+1)],[Y(i) Y(i+1)],'k','LineWidth',3);
                else
                    plot([X(i) X(i+1)],[Y(i) Y(i+1)],'k');
                end
            end
        end
        set(gca,'Layer','top');
        set(gca,'Ytick', 1 : length(config.hyp.contains),'Yticklabels',strrep(config.hyp.contains,'_',' '),'TickDir','out');
        axis tight;
        
        %     for i = 1 : length(X)-1
        %         if Y(i) == 0 && Y(i+1) == 0
        %             plot([X(i) X(i+1)],[6 6],'.r');
        %             text(X(i),6,datestr(X(i),13),'vert','bottom','horiz','center');
        %         end
        %     end
        
    end
    
    % add color legend for markers
    subplot(size(hyp_night,2)+1,1,size(hyp_night,2)+1); hold;
    
    for marker = 1 : numel(colortable.label)
        c = colortable.color(marker,:);
        x1 = marker*2;
        x2 = marker*2+1.5;
        fill([x1,x2,x2,x1],[0 0 1 1],c,'EdgeColor',c,'facealpha',1);
        text((x1+x2)/2,0.1,colortable.label(marker),'Rotation',90,'Fontsize',10);
        set(gca,'Layer','top');
    end
    set(gca,'XTick',[]);
    axis tight
    
    % print to file
    set(h,'PaperOrientation','landscape');
    set(h,'PaperUnits','normalized');
    set(h,'PaperPosition', [0 0 1 1]);
    set(h,'Renderer','Painters');
    print(h, '-dpdf', fullfile(config.imagesavedir,[config.prefix,'part',num2str(ipart),'-hypnogram.pdf']),'-r600');
    
%     % print a 3 meter version for fun
%     set(gcf,'PaperUnits','centimeters');
%     set(gcf,'PaperSize',[300 10]);
%     h.PaperUnits = 'centimeters';
%     h.PaperPosition = [0 0 300 10];
%     h.Units = 'centimeters';
%     h.PaperSize=[300 10];
%     h.Units = 'centimeters';
%     print(h, '-dpdf', fullfile(config.imagesavedir,[config.prefix,'part',num2str(ipart),'-hypnogram_3m.pdf']),'-r600');
    
    writetable(t,fullfile(config.datasavedir,[config.prefix,'part',num2str(ipart),'-hypnogram.txt']));
    
end
disp('Done');
