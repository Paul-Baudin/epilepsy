function readHdf5SpykCirc(p)
%
% Function which will:
%      - get the datas in the appropriate folder
%      - Read the hdf5 format in an usable format
%      - Save the raw data in the decided folder
%

    foldNames = dir(p.spikesFolders_path);
    
    % Go through each folder
    for i = 4:length(foldNames) % 4 to avoid the '.' '..' 'Read me'
        fname = foldNames(i).name;
        us = strfind(fname,'_');
        elecnam = fname(us(1)+1:us(3)-1);
        
        % If there is one folder containing datas from this patient
        if(str2num(fname(2:3)) == p.patienIdx)
            % Get the path of the folder containing the datas
            rawspikesPath = fullfile(p.spikesFolders_path, fname);
            fprintf('Loading spike data from: %s\n',fname);
            hdf5Names = dir(rawspikesPath);
            template_path = fullfile(rawspikesPath, [hdf5Names(3).name(1:end-4) p.suffix '.templates.hdf5']);
            datinfo     = h5info(template_path);
            
            %%
            % TIMESTAMPS
            %%
            % Have to gather the timestemp if 2 folders
            if p.nb_Neur_folder == 1
                hdr_fname = fullfile(p.rawData_path, ['*' elecnam '.ncs']);
                
                try 
                    hdr_fname = fullfile(p.rawData_path, ['*' elecnam '.ncs']);
                    hdr_fname = dir(hdr_fname);
                    % take the first file to extract the header of the data
                    hdr     = ft_read_header(fullfile(hdr_fname.folder,hdr_fname.name)); 
                catch % Somtime the index of the electrod is _02, sometimes _2
                    hdr_fname = fullfile(p.rawData_path, ['*' elecnam '.ncs']);
                    hdr_fname = dir(hdr_fname);
                    hdr_fname(end-5) = [];
                    hdr     = ft_read_header(fullfile(hdr_fname.folder,hdr_fname.name));
                end
                
                timestamps  =  (0:hdr.nSamples-1) * hdr.TimeStampPerSample;
                
            else
                timestamps = [];
                for idxFol = 1:p.nb_Neur_folder 
                    hdr_fname   = fullfile(p.rawData_path, ['*' elecnam '.ncs']);
                    
                    try 
                        hdr_fname   = fullfile([p.rawData_path num2str(idxFol)], ['*' elecnam '.ncs']);
                        hdr_fname = dir(hdr_fname);
                        hdr     = ft_read_header(fullfile(hdr_fname.folder,hdr_fname.name)); % take the first file to extract the header of the data
                    catch
                        hdr_fname   = fullfile([p.rawData_path num2str(idxFol)], ['*' elecnam '.ncs']);
                        hdr_fname(end-5) = [];
                        hdr_fname = dir(hdr_fname);
                        hdr     = ft_read_header(fullfile(hdr_fname.folder,hdr_fname.name));
                    end
                    
                    if idxFol == 1
                        timestamps   = (0:hdr.nSamples-1) * hdr.TimeStampPerSample;
                    else
                        timestamps =  [timestamps (timestamps(end)+1:timestamps(end)+hdr.nSamples)*hdr.TimeStampPerSample;] ;
                    end     
                end
            end
            
            %%
            % Read clusters spiketimes
            %%
            % read spiketimes of clusters
            for i = 1 : size(datinfo.Groups,1)
                names(i) = string(datinfo.Groups(i).Name);
                if strfind(names(i),'spiketimes')
                    spiketimes_indx = i;
                end
            end
            
        end
    end


end