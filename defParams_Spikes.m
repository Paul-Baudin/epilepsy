function [p] = defParams_Spikes()
%
%   Function which define and save the params of the experiment. 
%   This structure gather properly every information to set up at the start 
% of the analysis of patient data: No need to change anything in the code, 
% since this stucture is fully and correctly filled.
%   
%   Then, it also create the directories that we will need to store the 
% data if they do not already exist.
%

    p = {};
    
    %Experiment info 
    p.patienIdx          = 17;    %Patient nb
    p.date               = '2018-06-22';
    
    % Nb of folders containing datas
    if (ismember(p.patienIdx, [0 16 19 22 27 28 33 34]))
        p.nb_Neur_folder       = 1;        %true for patient 11,21,31,32,33,34 If we need to change the code cue and trigger;
    elseif (ismember(p.patienIdx, [17 20 24 25 26 30 32]))
        p.nb_Neur_folder       = 2; 
    else
        error('This patient number does not exists');
    end
    
    %Path for the Eprime folder and the script
    p.script_path         = pwd; %path where is located this script
    p.eprime_log_path    = ['D:\multiEEG\data_p' num2str(p.patienIdx)];    
    p.savedMatPath       = [pwd '\SavedMatrix\p' num2str(p.patienIdx)]; %path where we save the mat of this patient
    p.rawData_path       = ['D:\multiEEG\data_p' num2str(p.patienIdx) '\raw_data_p' num2str(p.patienIdx)];
    p.spikesFolders_path = 'D:\multiEEG\spikyChannels_Class1-2';
    % Get the path of the folder above to get the Macro elec dir
    mydir  = pwd;
    dir_idcs   = strfind(mydir,'\');
    fatherDir = mydir(1:dir_idcs(end)-1);
    p.savedMatPathMacro  = [fatherDir '\Zoe_Scripts_Macro\SavedMatrix\p' num2str(p.patienIdx)]; %path where we save the mat of this patient

    % Condition setup
    if (p.patienIdx == 16)
        p.cond               = {'NP', 'P'};        
    elseif (p.patienIdx == 10)
        p.cond               = {'NP'};  
    else
        p.cond               = {'NP', 'P', 'CP'};        %task condition: 
                                                   %  -CP=counter predictive (33% valid; 67% invalid)
                                                   %  -NP=non predictive (50% cued; 50% uncued)
                                                   %  -P=predictive (67% valid; 33% invalid)
    end
    
    p.prestim            = 1.45;                      % in Sec
    p.poststim           = 1.45;                      %downsampling frequency
    p.suffix             = '_generated';
    
    if (ismember(p.patienIdx, [0 11 21 31 32 33 34]))
        p.errorPatientTrig   = true;                      %true for patient 11,21,31,32,33,34 If we need to change the code cue and trigger;
    else
        p.errorPatientTrig   = false; 
    end
    
    p.spkCircusSave          = false;               % Choose to save new ncs for spykin circus analysis

    %%
    % Create Matrix folders
    %%
    
    % Create the folder where any patient matrix will be saved 
    if ~exist([p.script_path '\SavedMatrix'], 'dir')
      mkdir([p.script_path '\SavedMatrix']);
    end
    
    % Create the folder where the patient's matrix will be saved 
    if ~exist(p.savedMatPath, 'dir')
      mkdir(p.savedMatPath);
    end
    
    % If there are more than 2 folders, create a subfolder to save the raw
    % matrix
    if (p.nb_Neur_folder > 1)
        for i = 1:p.nb_Neur_folder
            if ~exist([p.savedMatPath '\raws'], 'dir')
              mkdir([p.savedMatPath '\raws']);
            end
        end
    end 
    
    % Create folder where the patient's dataEpoch matrix will be saved 
    if ~exist([p.savedMatPath '\dataEpoched'], 'dir')
      mkdir([p.savedMatPath '\dataEpoched']);
    end
    
    % Create folder where the patient's triggers matrix will be saved 
    if ~exist([p.savedMatPath '\triggers'], 'dir')
      mkdir([p.savedMatPath '\triggers']);
    end
    
    % Create folder where the patient's triggers matrix will be saved 
    if ~exist([p.savedMatPath '\params'], 'dir')
      mkdir([p.savedMatPath '\params']);
    end
    
    % Create folder where the Micro channels's coord will be saved 
    if ~exist([p.savedMatPath '\coordElecs'], 'dir')
      mkdir([p.savedMatPath '\coordElecs']);
    end
        
    % Create folder where the patient's Macro electrod layout 
    if ~exist([p.savedMatPath '\layout'], 'dir')
      mkdir([p.savedMatPath '\layout']);
    end
    
    % Create folder where the patient's Macro electrod layout 
    if ~exist([p.savedMatPath '\layout'], 'dir')
      mkdir([p.savedMatPath '\layout']);
    end
    
    % Save the structure params
    eval(['save ' p.savedMatPath '\params\p_' num2str(p.patienIdx) ' p']); %save the data epoched




end