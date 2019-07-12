%% Analysis script 
%
% (c) Stephen Whitmarsh, stephen.whitmarsh@gmail.com
%
% requires bandpassFilter.m from Mario
% requires releaseDec2015 from Neuralynx website

addpath /network/lustre/iss01/charpier/analyses/stephen.whitmarsh/scripts/
addpath /network/lustre/iss01/charpier/analyses/stephen.whitmarsh/fieldtrip/
ft_defaults


% addpath /network/lustre/iss01/charpier/stephen.whitmarsh/WhitmarshEpilepsy/mlib6/
% addpath /network/lustre/iss01/charpier/stephen.whitmarsh/WhitmarshEpilepsy/subaxis/

feature('DefaultCharacterSet', 'CP1252') % To fix bug for weird character problems in reading neurlynx
% maxNumCompThreads(4)


%% General analyses


for ipatient = 1 : 2
   
    % load settings
    config = seg_setparams([]);
    
    % read muse markers
    [MuseStruct_micro, MuseStruct_macro]    = readMuseMarkers(config{ipatient}, false); % false = reload from disk, true = redo the analysis if anything has changed
    
    % plot seizures
    plotSeizureSegmentation(config{ipatient},MuseStruct_micro);
    
end
