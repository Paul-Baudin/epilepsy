
%% Setting parameters DTX project Paul Boudin

function [config] = dtx_setparams(config)

disp('setting parameters');
muscale = 50; % multiunit scale

if ismac
    error('Platform not supported')
elseif isunix
    rootpath_analysis   = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh';
    rootpath_data       = '/network/lustre/iss01/epimicro/rodents/raw/DTX-raw/';
    os                  = 'unix'; 
elseif ispc
    rootpath_analysis	= '\\lexport\iss01.charpier\analyses\stephen.whitmarsh';
    rootpath_data       = '\\lexport\iss01.epimicro\rodents\raw\DTX-raw\';
    os                  = 'windows';
else
    error('Platform not supported')
end

% Rodent 1
config{1}.os                        = os;
config{1}.name                      = { 'SlowWave'};
config{1}.prefix                    = 'DTX5-';
config{1}.muse.startend             = { 'SlowWave','SlowWave'};   % start and end Muse marker
config{1}.rawdir                    = fullfile(rootpath_data, 'DTX5-M1-10uM', '2019_03_19_DTX-5');
config{1}.datasavedir               = fullfile(rootpath_analysis, 'data',   'dtx');         % where to write data
config{1}.imagesavedir              = fullfile(rootpath_analysis, 'images', 'dtx');       % where to print images
config{1}.directory_searchstring    = '2019*';
config{1}.labels.micro              = {'E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{1}.labels.macro              = {'E07LFP','E08LFP','E09LFP','E10LFP','E11LFP','E12LFP','E13LFP','E14LFP','E15LFP'};
config{1}.align.name                = {'SlowWave'};
config{1}.align.channel             = {'E12.ncs'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{1}.align.flip                = {'no'};
config{1}.align.abs                 = {'no'};
config{1}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{1}.align.filter              = {'lp'};
config{1}.align.freq                = {5};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{1}.align.hilbert             = {'no'};
config{1}.align.thresh              = [0];
config{1}.align.toiplot{1}          = [-1,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{1}.align.toiactive{1}        = [-0.5, 0.5];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{1}.align.toibaseline{1}      = [-1, -0.5];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{1}.LFP.name                  = {'SlowWave'};
config{1}.LFP.hpfilter              = 'no';
config{1}.LFP.hpfreq                = 1;
config{1}.LFP.resamplefs            = 1000;
config{1}.LFP.baseline              = 'yes';
config{1}.LFP.baselinewindow{1}     = [-2, -1];
config{1}.LFP.slidestep             = 0.01;
config{1}.epoch.toi{1}              = [-5,  25];           
% list of onset timing with respect tostart-marker (s)
config{1}.epoch.pad                 = 0.5;
config{1}.circus.channel            = {'E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{1}.circus.reref              = 'no';
config{1}.circus.refchan            = '';
config{1}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'dtx', 'SpykingCircus');
config{1}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{1}.circus.suffix             = '';
config{1}.stats.actoi{1}            = [-4, 25];
config{1}.stats.bltoi{1}            = [-5, -4];
config{1}.stats.alpha               = 0.025;

config{1}.spike.slidestep           = [0.01];
config{1}.spike.toispikerate{1}     = [-0.1 0.1];           % for plotting spikerate
config{1}.spike.resamplefs          = 1000;
config{1}.spike.bltoi{1}            = [-5, -4];



% Rodent 2
config{2}.os                        = os;
config{2}.name                      = { 'SlowWave','Crise','Injection'};
config{2}.prefix                    = 'DTX2-';
config{2}.muse.startend             = { 'SlowWave','SlowWave';'Crise_Start','Crise_End';'Injection','Injection'};   % start and end Muse marker
config{2}.rawdir                    = fullfile(rootpath_data, 'DTX2-M1-10uM', '2019_03_01_DTX-2');
config{2}.datasavedir               = fullfile(rootpath_analysis, 'data',   'dtx');         % where to write data
config{2}.imagesavedir              = fullfile(rootpath_analysis, 'images', 'dtx');       % where to print images
config{2}.directory_searchstring    = '2019*';
config{2}.labels.micro              = {'E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{2}.labels.macro              = {'E08LFP','E09LFP','E10LFP','E11LFP','E12LFP','E13LFP','E14LFP','E15LFP','E16LFP'};
config{2}.align.name                = {'SlowWave'};
config{2}.align.channel             = {'E13.ncs'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{2}.align.flip                = {'no'};
config{2}.align.abs                 = {'no'};
config{2}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{2}.align.filter              = {'lp'};
config{2}.align.freq                = {5};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{2}.align.hilbert             = {'no'};
config{2}.align.thresh              = [0];
config{2}.align.toiplot{1}          = [-1,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{2}.align.toiactive{1}        = [-0.5, 0.5];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{2}.align.toibaseline{1}      = [-1, -0.5];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{2}.LFP.name                  = {'SlowWave'};
config{2}.LFP.hpfilter              = 'no';
config{2}.LFP.hpfreq                = 1;
config{2}.LFP.resamplefs            = 1000;
config{2}.LFP.baseline              = 'yes';
config{2}.LFP.baselinewindow{1}     = [-2, -1];
config{2}.LFP.slidestep             = 0.01;
config{2}.epoch.toi                 = {[-5,  25]};                                                                  % list of onset timing with respect to start-marker (s)
config{2}.epoch.pad                 = 0.5;
config{2}.circus.channel            = {'E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{2}.circus.reref              = 'no';
config{2}.circus.refchan            = '';
config{2}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'dtx', 'SpykingCircus');
config{2}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{2}.stats.actoi{1}            = [-10, 3];
config{2}.stats.actoi{2}            = [-1, 10];
config{2}.stats.actoi{3}            = [-0.15, 0.15]; 
config{2}.stats.bltoi{1}            = [-12, -10];
config{2}.stats.bltoi{2}            = [-2, -1];
config{2}.stats.bltoi{3}            = [-1,  -0.5];
config{2}.stats.alpha               = 0.025;

% Rodent 3
config{3}.os                        = os;
config{3}.name                      = { 'SlowWave','Crise','Injection'};
config{3}.prefix                    = 'DTX4-';
config{3}.muse.startend             = { 'SlowWave','SlowWave';'Crise_Start','Crise_End';'Injection','Injection'};   % start and end Muse marker
config{3}.rawdir                    = fullfile(rootpath_data, 'DTX4-M1-10uM', '2019_03_08_DTX-4');
config{3}.datasavedir               = fullfile(rootpath_analysis, 'data',   'dtx');         % where to write data
config{3}.imagesavedir              = fullfile(rootpath_analysis, 'images', 'dtx');       % where to print images
config{3}.directory_searchstring    = '2019*';
config{3}.labels.micro              = {'E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{3}.labels.macro              = {'E07LFP','E08LFP','E09LFP','E10LFP','E11LFP','E12LFP','E13LFP','E14LFP','E15LFP','E16LFP'};
config{3}.align.name                = {'SlowWave'};
config{3}.align.channel             = {'E13.ncs'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{3}.align.flip                = {'no'};
config{3}.align.abs                 = {'no'};
config{3}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{3}.align.filter              = {'lp'};
config{3}.align.freq                = {5};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{3}.align.hilbert             = {'no'};
config{3}.align.thresh              = [0];
config{3}.align.toiplot{1}          = [-1,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{3}.align.toiactive{1}        = [-0.5, 0.5];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{3}.align.toibaseline{1}      = [-1, -0.5];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{3}.LFP.name                  = {'SlowWave'};
config{3}.LFP.hpfilter              = 'no';
config{3}.LFP.hpfreq                = 1;
config{3}.LFP.resamplefs            = 1000;
config{3}.LFP.baseline              = 'yes';
config{3}.LFP.baselinewindow{1}     = [-2, -1];
config{3}.LFP.slidestep             = 0.01;
config{3}.epoch.toi                 = {[-5,  25]};                                                                  % list of onset timing with respect to start-marker (s)
config{3}.epoch.pad                 = 0.5;
config{3}.circus.channel            = {'E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{3}.circus.reref              = 'no';
config{3}.circus.refchan            = '';
config{3}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'dtx', 'SpykingCircus');
config{3}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{3}.stats.actoi{1}            = [-10, 3];
config{3}.stats.actoi{2}            = [-1, 10];
config{3}.stats.actoi{3}            = [-0.15, 0.15]; 
config{3}.stats.bltoi{1}            = [-12, -10];
config{3}.stats.bltoi{2}            = [-2, -1];
config{3}.stats.bltoi{3}            = [-1,  -0.5];
config{3}.stats.alpha               = 0.025;

% Rodent 4
config{4}.os                        = os;
config{4}.name                      = { 'SlowWave','Crise','Injection'};
config{4}.prefix                    = 'DTX10-';
config{4}.muse.startend             = { 'SlowWave','SlowWave';'Crise_Start','Crise_End';'Injection','Injection'};   % start and end Muse marker
config{4}.rawdir                    = fullfile(rootpath_data, 'DTX10-M1-10uM', '2019_03_28_DTX-10');
config{4}.datasavedir               = fullfile(rootpath_analysis, 'data',   'dtx');         % where to write data
config{4}.imagesavedir              = fullfile(rootpath_analysis, 'images', 'dtx');       % where to print images
config{4}.directory_searchstring    = '2019*';
config{4}.labels.micro              = {'E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{4}.labels.macro              = {'E08LFP','E09LFP','E10LFP','E11LFP','E12LFP','E13LFP','E14LFP','E15LFP','E16LFP'};
config{4}.align.name                = {'SlowWave'};
config{4}.align.channel             = {'E13.ncs'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{4}.align.flip                = {'no'};
config{4}.align.abs                 = {'no'};
config{4}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{4}.align.filter              = {'lp'};
config{4}.align.freq                = {5};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{4}.align.hilbert             = {'no'};
config{4}.align.thresh              = [0];
config{4}.align.toiplot{1}          = [-1,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{4}.align.toiactive{1}        = [-0.5, 0.5];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{4}.align.toibaseline{1}      = [-1, -0.5];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{4}.LFP.name                  = {'SlowWave'};
config{4}.LFP.hpfilter              = 'no';
config{4}.LFP.hpfreq                = 1;
config{4}.LFP.resamplefs            = 1000;
config{4}.LFP.baseline              = 'yes';
config{4}.LFP.baselinewindow{1}     = [-2, -1];
config{4}.LFP.slidestep             = 0.01;
config{4}.epoch.toi                 = {[-5,  25]};                                                                  % list of onset timing with respect to start-marker (s)
config{4}.epoch.pad                 = 0.5;
config{4}.circus.channel            = {'E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{4}.circus.reref              = 'no';
config{4}.circus.refchan            = '';
config{4}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'dtx', 'SpykingCircus');
config{4}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{4}.stats.actoi{1}            = [-10, 3];
config{4}.stats.actoi{2}            = [-1, 10];
config{4}.stats.actoi{3}            = [-0.15, 0.15]; 
config{4}.stats.bltoi{1}            = [-12, -10];
config{4}.stats.bltoi{2}            = [-2, -1];
config{4}.stats.bltoi{3}            = [-1,  -0.5];
config{4}.stats.alpha               = 0.025;

% Rodent 5
config{5}.os                        = os;
config{5}.name                      = { 'SlowWave','Crise','Injection'};
config{5}.prefix                    = 'DTX7-';
config{5}.muse.startend             = { 'SlowWave','SlowWave';'Crise_Start','Crise_End';'Injection','Injection'};   % start and end Muse marker
config{5}.rawdir                    = fullfile(rootpath_data, 'DTX7-M1-10uM', '2019_03_22_DTX-7');
config{5}.datasavedir               = fullfile(rootpath_analysis, 'data',   'dtx');         % where to write data
config{5}.imagesavedir              = fullfile(rootpath_analysis, 'images', 'dtx');       % where to print images
config{5}.directory_searchstring    = '2019*';
config{5}.labels.micro              = {'E06','E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{5}.labels.macro              = {'E06LFP','E07LFP','E08LFP','E09LFP','E10LFP','E11LFP','E12LFP','E13LFP','E14LFP','E15LFP','E16LFP'};
config{5}.align.name                = {'SlowWave'};
config{5}.align.channel             = {'E13.ncs'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{5}.align.flip                = {'no'};
config{5}.align.abs                 = {'no'};
config{5}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{5}.align.filter              = {'lp'};
config{5}.align.freq                = {5};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{5}.align.hilbert             = {'no'};
config{5}.align.thresh              = [0];
config{5}.align.toiplot{1}          = [-1,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{5}.align.toiactive{1}        = [-0.5, 0.5];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{5}.align.toibaseline{1}      = [-1, -0.5];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{5}.LFP.name                  = {'SlowWave'};
config{5}.LFP.hpfilter              = 'no';
config{5}.LFP.hpfreq                = 1;
config{5}.LFP.resamplefs            = 1000;
config{5}.LFP.baseline              = 'yes';
config{5}.LFP.baselinewindow{1}     = [-2, -1];
config{5}.LFP.slidestep             = 0.01;
config{5}.epoch.toi                 = {[-5,  25]};                                                                  % list of onset timing with respect to start-marker (s)
config{5}.epoch.pad                 = 0.5;
config{5}.circus.channel            = {'E06','E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{5}.circus.reref              = 'no';
config{5}.circus.refchan            = '';
config{5}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'dtx', 'SpykingCircus');
config{5}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{5}.stats.actoi{1}            = [-10, 3];
config{5}.stats.actoi{2}            = [-1, 10];
config{5}.stats.actoi{3}            = [-0.15, 0.15]; 
config{5}.stats.bltoi{1}            = [-12, -10];
config{5}.stats.bltoi{2}            = [-2, -1];
config{5}.stats.bltoi{3}            = [-1,  -0.5];
config{5}.stats.alpha               = 0.025;

% Rodent 6
config{6}.os                        = os;
config{6}.name                      = { 'SlowWave','Crise','Injection'};
config{6}.prefix                    = 'DTX6-';
config{6}.muse.startend             = { 'SlowWave','SlowWave';'Crise_Start','Crise_End';'Injection','Injection'};   % start and end Muse marker
config{6}.rawdir                    = fullfile(rootpath_data, 'DTX6-M1-10uM', '2019_03_21_DTX-6');
config{6}.datasavedir               = fullfile(rootpath_analysis, 'data',   'dtx');         % where to write data
config{6}.imagesavedir              = fullfile(rootpath_analysis, 'images', 'dtx');       % where to print images
config{6}.directory_searchstring    = '2019*';
config{6}.labels.micro              = {'E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{6}.labels.macro              = {'E08LFP','E09LFP','E10LFP','E11LFP','E12LFP','E13LFP','E14LFP','E15LFP','E16LFP'};
config{6}.align.name                = {'SlowWave'};
config{6}.align.channel             = {'E13.ncs'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{6}.align.flip                = {'no'};
config{6}.align.abs                 = {'no'};
config{6}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{6}.align.filter              = {'lp'};
config{6}.align.freq                = {5};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{6}.align.hilbert             = {'no'};
config{6}.align.thresh              = [0];
config{6}.align.toiplot{1}          = [-1,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{6}.align.toiactive{1}        = [-0.5, 0.5];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{6}.align.toibaseline{1}      = [-1, -0.5];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{6}.LFP.name                  = {'SlowWave'};
config{6}.LFP.hpfilter              = 'no';
config{6}.LFP.hpfreq                = 1;
config{6}.LFP.resamplefs            = 1000;
config{6}.LFP.baseline              = 'yes';
config{6}.LFP.baselinewindow{1}     = [-2, -1];
config{6}.LFP.slidestep             = 0.01;
config{6}.epoch.toi                 = {[-5,  25]};                                                                  % list of onset timing with respect to start-marker (s)
config{6}.epoch.pad                 = 0.5;
config{6}.circus.channel            = {'E07','E08','E09','E10','E11','E12','E13','E14','E15','E16'};
config{6}.circus.reref              = 'no';
config{6}.circus.refchan            = '';
config{6}.circus.outputdir          = fullfile(rootpath_analysis, 'data', 'dtx', 'SpykingCircus');
config{6}.circus.hpfilter           = 'no'; % hp before writing data for SC, does not change the hp of SC
config{6}.stats.actoi{1}            = [-10, 3];
config{6}.stats.actoi{2}            = [-1, 10];
config{6}.stats.actoi{3}            = [-0.15, 0.15]; 
config{6}.stats.bltoi{1}            = [-12, -10];
config{6}.stats.bltoi{2}            = [-2, -1];
config{6}.stats.bltoi{3}            = [-1,  -0.5];
config{6}.stats.alpha               = 0.025;

end




