
%% Setting parameters

function [config] = sw_setparams(config)

disp('setting parameters');

muscale = 50; % multiunit scale

% Patient 1, perivetricular heterotopia #1
config{1}.name                      = { 'Hspike'};
config{1}.prefix                    = 'P1-';
config{1}.muse.startend             = { 'Hspike','Hspike'};   % start and end Muse marker
config{1}.patientdir                = '/network/lustre/iss01/epimicro/patients/raw/pat_02711_1193';
config{1}.datasavedir               = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/data/hspike';         % where to write data
config{1}.imagesavedir              = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/images/hspike';       % where to print images
config{1}.rawdir                    = '/network/lustre/iss01/epimicro/patients/raw/pat_02711_1193/eeg/';
config{1}.directory_searchstring    = '02711_2019-04-*';
config{1}.labels.micro              = {'mHaT2_1'};
config{1}.labels.macro              = {'_HaT2_1'};

config{1}.hyp.imagesavedir          = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/images/hypnogram'; 
config{1}.hyp.backupdir             = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/markerbackup';
config{1}.hyp.micromedchannel       = 'F3p6';
config{1}.hyp.contains              = {'NO_SCORE','AWAKE','PHASE_1','PHASE_2','PHASE_3','REM'}; % in order of height in plot
config{1}.hyp.markers               = {'Hspike','BAD'};
config{1}.hyp.markerdir             = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/data/hspike';
% config{1}.hyp.notcontains           = {"ADStartLoss","ADEndLoss","TTL","StartRecord","StopRecord","NLXEvent","BAD"};

config{1}.align.channel             = {'_HaT2_1'};                                                                                    % pattern to identify channel on which to based peak detection                                                                        % peak threshold: fraction (0:inf) of mean peak amplitude in baseline period
config{1}.align.flip                = {'yes'};
config{1}.align.abs                 = {'no'};
config{1}.align.method              = {'max'};                                                              % whether to align to max, first-after-zero, or nearest-to-t-zero peak, maxabs {'max','first', 'nearest', 'maxabs'}
config{1}.align.filter              = {'none'};
config{1}.align.freq                = {[1, 40]};                                                                                  % lowpass filter freq to smooth peak detection (Hz)
config{1}.align.hilbert             = {'no'};
config{1}.align.thresh              = [0];
config{1}.align.toiplot{1}          = [-0.5,  1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];
config{1}.align.toiactive{1}        = [-0.06, 0.06];                                            % active period in which to search for peaks [ -0.1,  30;  0, 30;  -0.1, 0.1;0,  0.1];
config{1}.align.toibaseline{1}      = [-0.2, -0.1];                                            % baseline period in which to search for peaks [ -1,  0; -1,  0;  -1,  -0.1;  -1, -0.1];

config{1}.pattern.startmarker       = 'StartHypnogram';
config{1}.pattern.endmarker         = 'EndHypnogram';


config{1}.LFP.hpfilter              = 'no';
config{1}.LFP.hpfreq                = 1;
config{1}.LFP.resamplefs            = 1000;
config{1}.LFP.baseline              = 'yes';
config{1}.LFP.baselinewindow{1}     = [-2, -1];
config{1}.LFP.slidestep             = [0.01];

config{1}.epoch.toi{1}              = [-0.6,  0.9];                                                                  % list of onset timing with respect to start-marker (s)
config{1}.epoch.pad                 = [0.5, 0.5, 0.5];

config{1}.circus.channel            = {'m1pNs_1','m1pNs_2','m1pNs_6','m1pNs_7','m1pNs_8'};
config{1}.circus.reref              = 'yes';
config{1}.circus.refchan            = 'm1pNs_4';
config{1}.circus.outputdir          = 'SpykingCircus';
config{1}.circus.suffix             = '-2';

config{1}.spike.slidestep           = [0.01, 0.01, 0.001];
config{1}.spike.toispikerate{1}     = [-0.1 0.1];         % for plotting spikerate
config{1}.spike.resamplefs          = 1000;
config{1}.spike.width               = 15;

config{1}.stats.bltoi{1}            = [-2,    -1];
config{1}.stats.bltoi{2}            = [-2,    -1];
config{1}.stats.bltoi{3}            = [-1,  -0.5];
config{1}.stats.alpha               = 0.025;

config{1}.plot.toi{1}               = [1500.8, 1503.3, 0];
config{1}.plot.hpfilter{1}{1}       = 'no';
config{1}.plot.hpfreq{1}{1}         = [];
config{1}.plot.hpfreq{1}{2}         = [];
config{1}.plot.hpfreq{1}{3}         = [];
config{1}.plot.hpfreq{1}{4}         = [];
config{1}.plot.hpfreq{1}{5}         = 500;
config{1}.plot.hpfreq{1}{6}         = 500;
config{1}.plot.lpfilter{1}{1}       = 'yes';
config{1}.plot.lpfilter{1}{2}       = 'yes';
config{1}.plot.lpfilter{1}{3}       = 'yes';
config{1}.plot.lpfilter{1}{4}       = 'yes';
config{1}.plot.lpfilter{1}{5}       = 'yes';
config{1}.plot.lpfilter{1}{6}       = 'yes';
config{1}.plot.lpfreq{1}{1}         = 500;
config{1}.plot.lpfreq{1}{2}         = 500;
config{1}.plot.lpfreq{1}{3}         = 500;
config{1}.plot.lpfreq{1}{4}         = 500;
config{1}.plot.lpfreq{1}{5}         = 3000;
config{1}.plot.lpfreq{1}{6}         = 3000;
config{1}.plot.fname{1}{1}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_2.ncs';
config{1}.plot.fname{1}{2}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_1.ncs';
config{1}.plot.fname{1}{3}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_4.ncs';
config{1}.plot.fname{1}{4}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_6.ncs';
config{1}.plot.fname{1}{5}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_1.ncs';
config{1}.plot.fname{1}{6}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_2.ncs';
config{1}.plot.refname{1}{1}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_3.ncs';
config{1}.plot.refname{1}{2}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_2.ncs';
config{1}.plot.refname{1}{3}        = [];
config{1}.plot.refname{1}{4}        = [];
config{1}.plot.refname{1}{5}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_4.ncs';
config{1}.plot.refname{1}{6}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_4.ncs';
config{1}.plot.scale{1}{1}          = [-200 200];
config{1}.plot.scale{1}{2}          = [-200 200];
config{1}.plot.scale{1}{3}          = [-200 200];
config{1}.plot.scale{1}{4}          = [-200 200];
config{1}.plot.scale{1}{5}          = [-muscale muscale];
config{1}.plot.scale{1}{6}          = [-muscale muscale];

config{1}.plot.toi{2}               = [1976.2-0.5, 1976.2+2, -0.5];
config{1}.plot.hpfilter{2}{1}       = 'no';
config{1}.plot.hpfilter{2}{2}       = 'no';
config{1}.plot.hpfilter{2}{3}       = 'no';
config{1}.plot.hpfilter{2}{4}       = 'no';
config{1}.plot.hpfilter{2}{5}       = 'yes';
config{1}.plot.hpfilter{2}{6}       = 'yes';
config{1}.plot.hpfreq{2}{1}         = [];
config{1}.plot.hpfreq{2}{2}         = [];
config{1}.plot.hpfreq{2}{3}         = [];
config{1}.plot.hpfreq{2}{4}         = [];
config{1}.plot.hpfreq{2}{5}         = 500;
config{1}.plot.hpfreq{2}{6}         = 500;
config{1}.plot.lpfilter{2}{1}       = 'yes';
config{1}.plot.lpfilter{2}{2}       = 'yes';
config{1}.plot.lpfilter{2}{3}       = 'yes';
config{1}.plot.lpfilter{2}{4}       = 'yes';
config{1}.plot.lpfilter{2}{5}       = 'yes';
config{1}.plot.lpfilter{2}{6}       = 'yes';
config{1}.plot.lpfreq{2}{1}         = 500;
config{1}.plot.lpfreq{2}{2}         = 500;
config{1}.plot.lpfreq{2}{3}         = 500;
config{1}.plot.lpfreq{2}{4}         = 500;
config{1}.plot.lpfreq{2}{5}         = 3000;
config{1}.plot.lpfreq{2}{6}         = 3000;
config{1}.plot.fname{2}{1}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_2.ncs';
config{1}.plot.fname{2}{2}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_1.ncs';
config{1}.plot.fname{2}{3}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_4.ncs';
config{1}.plot.fname{2}{4}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_6.ncs';
config{1}.plot.fname{2}{5}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_1.ncs';
config{1}.plot.fname{2}{6}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_8.ncs';
config{1}.plot.refname{2}{1}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_3.ncs';
config{1}.plot.refname{2}{2}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_1pNs_2.ncs';
config{1}.plot.refname{2}{3}        = [];
config{1}.plot.refname{2}{4}        = [];
config{1}.plot.refname{2}{5}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_4.ncs';
config{1}.plot.refname{2}{6}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_17-16/02230_2015-02-25_17-16_m1pNs_4.ncs';
config{1}.plot.scale{2}{1}          = [-200 200];
config{1}.plot.scale{2}{2}          = [-200 200];
config{1}.plot.scale{2}{3}          = [-200 200];
config{1}.plot.scale{2}{4}          = [-200 200];
config{1}.plot.scale{2}{5}          = [-muscale muscale];
config{1}.plot.scale{2}{6}          = [-muscale muscale];

config{1}.plot.toi{3}               = [894.659-0.4, 894.659+0.4, -0.4];
config{1}.plot.hpfilter{3}{1}       = 'no';
config{1}.plot.hpfilter{3}{2}       = 'no';
config{1}.plot.hpfilter{3}{3}       = 'no';
config{1}.plot.hpfilter{3}{4}       = 'no';
config{1}.plot.hpfilter{3}{5}       = 'yes';
config{1}.plot.hpfilter{3}{6}       = 'yes';
config{1}.plot.hpfreq{3}{1}         = [];
config{1}.plot.hpfreq{3}{2}         = [];
config{1}.plot.hpfreq{3}{3}         = [];
config{1}.plot.hpfreq{3}{4}         = [];
config{1}.plot.hpfreq{3}{5}         = 500;
config{1}.plot.hpfreq{3}{6}         = 500;
config{1}.plot.lpfilter{3}{1}       = 'yes';
config{1}.plot.lpfilter{3}{2}       = 'yes';
config{1}.plot.lpfilter{3}{3}       = 'yes';
config{1}.plot.lpfilter{3}{4}       = 'yes';
config{1}.plot.lpfilter{3}{5}       = 'yes';
config{1}.plot.lpfilter{3}{6}       = 'yes';
config{1}.plot.lpfreq{3}{1}         = 500;
config{1}.plot.lpfreq{3}{2}         = 500;
config{1}.plot.lpfreq{3}{3}         = 500;
config{1}.plot.lpfreq{3}{4}         = 500;
config{1}.plot.lpfreq{3}{5}         = 3000;
config{1}.plot.lpfreq{3}{6}         = 3000;
config{1}.plot.fname{3}{1}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_1pNs_2.ncs';
config{1}.plot.fname{3}{2}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_1pNs_1.ncs';
config{1}.plot.fname{3}{3}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_m1pNs_4.ncs';
config{1}.plot.fname{3}{4}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_m1pNs_6.ncs';
config{1}.plot.fname{3}{5}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_m1pNs_1.ncs';
config{1}.plot.fname{3}{6}          = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_m1pNs_8.ncs';

config{1}.plot.refname{3}{1}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_1pNs_3.ncs';
config{1}.plot.refname{3}{2}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_1pNs_2.ncs';
config{1}.plot.refname{3}{3}        = [];
config{1}.plot.refname{3}{4}        = [];
config{1}.plot.refname{3}{5}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_m1pNs_4.ncs';
config{1}.plot.refname{3}{6}        = '/network/lustre/iss01/charpier/stephen.whitmarsh/data/pat_02230_0674/eeg/02230_2015-02-25_14-36/02230_2015-02-25_14-36_m1pNs_4.ncs';
config{1}.plot.scale{3}{1}          = [-200 200];
config{1}.plot.scale{3}{2}          = [-200 200];
config{1}.plot.scale{3}{3}          = [-200 200];
config{1}.plot.scale{3}{4}          = [-200 200];
config{1}.plot.scale{3}{5}          = [-muscale muscale];
config{1}.plot.scale{3}{6}          = [-muscale muscale];

end
