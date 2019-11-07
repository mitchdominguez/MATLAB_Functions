%% Mitchell Dominguez - plot_conic.m
% Plot a conic section given the Keplerian orbital elements
% Outputs:
%   iCp = rotation matrix from perifocal to inertial frame
%   r_rotated = position of the SC at each given true anomaly
%   f = figure handle for the plotted figure
%   plot_objs = handles to plot objects
% Inputs:
%   thstars = vector defining the true anomalies to plot (given in degrees)
%   orbit = struct containing the following fields:
%       SMA = semimajor axis
%       ECC = eccentricity
%       AOP = angle of periapsis
%       RAAN = longitude of the ascending node
%       INC = inclination
%   units = 'rad' or 'deg', specifying units that angular COEs are given in
%   plotstyle = style to plot the orbit in
%   f = figure handle to plot on

function [iCp,r_rotated,f,plot_objs] = plot_conic(thstars, orbit, units, plotstyle, f)
    [iCp, r_rotated, f, plot_objs] = plot_conic_3D(thstars, orbit.SMA, orbit.ECC, orbit.AOP, orbit.RAAN, orbit.INC, units, plotstyle, f);
end
