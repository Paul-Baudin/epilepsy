
%% Setting parameters

function [config] = seg_setparams(config)

disp('setting parameters');

% patient 1
config{1}.prefix                    = 'seg_2599_';                                                                  % unique prefix for outputfiles to keep things organized
config{1}.datasavedir               = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/data/seg';         % where to write data
config{1}.imagesavedir              = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/images/seg';       % where to print images
config{1}.rawdir                    = '/network/lustre/iss01/epimicro/patients/raw/pat_02599_1057/eeg/';            % where is the original data
config{1}.labels.macro              = {'_HaT2_1'};                                                                  % at least one macro for calculating sample rate etc.
config{1}.labels.micro              = {'mHaT2_1'};                                                                  % at least one micro for calculating sample rate etc.
config{1}.directory_searchstring    = '*';

% patient 2
config{2}.prefix                    = 'seg_2256_';
config{2}.datasavedir               = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/data/seg';
config{2}.imagesavedir              = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/images/seg';
config{2}.rawdir                    = '/network/lustre/iss01/epimicro/patients/raw/pat_02256_0700/eeg/';
config{2}.labels.macro              = {'_Cinp_1'};
config{2}.labels.micro              = {'mCinp_1'};
config{2}.directory_searchstring    = '*';

% patient 3
config{3}.prefix                    = 'seg_xxx_';
config{3}.datasavedir               = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/data/seg';
config{3}.imagesavedir              = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/images/seg';
config{3}.rawdir                    = '/network/lustre/iss01/epimicro/patients/raw/pat_xxxx_xxxx/eeg/';
config{3}.labels.macro              = {'_HaT2_1'};
config{3}.labels.micro              = {'mHaT2_1'};
config{3}.directory_searchstring    = '*';

end
