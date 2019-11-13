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

function phi = orbit_phasing(tof, n, e, max_iter, tol)
    M = pi - n*tof;
    [E, err] = kepler_time_NR(M, e, max_iter, tol);
    phi = 2*atand(sqrt((1+e)/(1-e))*tan(E/2));
end
