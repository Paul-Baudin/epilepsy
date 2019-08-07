%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Main code aiming to load the data and preprocess it
%
%%%%%%%%%%%%%%%%%%%%%%%%%

%Path to access fieldtrip and NEuralinx codes
addpath('C:\Program Files\MATLAB\fieldtrip');
ft_defaults
addpath('C:\Program Files\MATLAB\NeuralynxMatlabImportExportv6')

% Define all necessary params (FILL CORRECTLY BEFORE ANYTHING)
p = defParams_Spikes();

%% Load signal spikes
readHdf5SpykCirc(p);