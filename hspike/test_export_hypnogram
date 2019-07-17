
addpath /network/lustre/iss01/charpier/analyses/stephen.whitmarsh/scripts/epilepsy/
addpath /network/lustre/iss01/charpier/analyses/stephen.whitmarsh/scripts/epilepsy/hspike/
addpath /network/lustre/iss01/charpier/analyses/stephen.whitmarsh/scripts/epilepsy/shared/
addpath /network/lustre/iss01/charpier/analyses/stephen.whitmarsh/fieldtrip/

ft_defaults

cfg                   = [];
cfg.patientdir        = '/network/lustre/iss01/epimicro/patients/raw/pat_02711_1193';
cfg.micromedchannel   = 'F3p6';
cfg.imagesavedir      = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/images/hspike'; 
cfg.prefix            = 'P1-';
cfg.backupdir         = '/network/lustre/iss01/charpier/analyses/stephen.whitmarsh/markerbackup';
export_hypnogram(cfg);