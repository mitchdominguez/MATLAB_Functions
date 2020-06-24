%% Mitchell Dominguez - orbit_phasing.m
% Calculate the phase angle for a Hohmann transfer between two
% elliptical orbits.
%
% Assumptions
%   - Target orbit is elliptical or circular
%
% Outputs:
%   phi = phase angle [deg]
% Inputs:
%   tof = time of flight of transfer [time]
%   n = mean motion of target orbit [rad/time]
%   e = eccentricity of target orbit
%   max_iter = maximum iterations allowed when solving the Kepler Time Equation
%   tol = convergence criteria for solving KTE
%   transfer_angle = transfer angle [deg] NOTE UNITS HERE

function phi = orbit_phasing(tof, n, e, max_iter, tol, transfer_angle)
    if nargin < 6
        transfer_angle = pi;
    else
        transfer_angle = deg2rad(transfer_angle);
    end

    M = transfer_angle - n*tof;
    [E, err] = kepler_time_NR(M, e, max_iter, tol);
    phi = 2*atand(sqrt((1+e)/(1-e))*tan(E/2));
end
