clc
clear

% Determine where your m-file's folder is.
folder = fileparts(which('UCR_dota'));
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));