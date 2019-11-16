%% Mitchell Dominguez - pre_flyby_2D.m
% Calculate the exit velocity of a spacecraft on a hyperbolic
% flyby around a planet
%
% TODO
%   - Check for quadrant for true anomaly and flight path angle
%
% Assumptions:
%   - Distance between the planet and the spacecraft is small relative to the 
%     distance between the spacecraft and the sun
%   - Only the local gravity field of the planet is acting on the spacecraft
%   - Point masses
%   - No atmospheric drag
%
% Outputs:
%   x_m = struct containing information pre-flyby
%
% Inputs:
%   orbit1 = struct containing orbit pre-flyby -- must have fields 'a' and 'e'
%   planet = struct containing flyby planet information -- must have fields 'mu', 'a'
%   sun = struct containing flyby sun information -- must have fields 'mu'
%   ta_sign = +1 for point on ascending half of orbit, -1 for point on descending half of orbit

function [x_m] = pre_flyby_2D(orbit1, planet, sun, ta_sign)
    define_xyz;

    ta_sign = ta_sign/abs(ta_sign); % Ensure ta_sign is +/- 1

    if ~isfield(orbit1,'AOP')
        orbit1.AOP = 0;
    end

    % Get initial values at flyby point
    orbit1.TA  = ta_sign*ta_conic(planet.a, orbit1.a, orbit1.e, 'deg'); % initial true anomaly
    x_m = coe2rv(orbit1, sun.mu);
    x_m.thstar = orbit1.TA;
    x_m.eps = -sun.mu/(2*x_m.oe.SMA);

end
