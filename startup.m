%addpath MATLAB
% addpath MATLAB\CVX
startup_path = which('startup');
startup_path = startup_path(1:end-9);
p = genpath([startup_path, '/Orbits']);
addpath(p)
set(0,'defaulttextInterpreter','latex') %latex axis labels
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');
set(0,'DefaultAxesFontSize',12)
set(0,'DefaultAxesTitleFontSizeMultiplier',1.2)
set(0,'DefaultAxesLabelFontSizeMultiplier',1.2)
