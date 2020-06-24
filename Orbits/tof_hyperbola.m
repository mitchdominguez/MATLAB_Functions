%% Mitchell Dominguez - tof_hyperbola.m
% Find the time of flight between two hyperbolic anomalies on a
% hyperbolic orbit
%
% Outputs:
%   tof = time of flight (in seconds)
%
% Inputs:
%   mu = gravitational parameter [km3/s2]
%   a = semimajor axis of orbit [km]
%   e = eccentricity of orbit
%   H_1 = hyperbolic anomaly at departure [units]
%   H_2 = hyperbolic anomaly at arrival [units]
%   units = 'deg' or 'rad', specifying units of eccentric anomaly

function tof = tof_hyperbola(mu, a, e, H_1, H_2)
    n = sqrt(mu/abs(a)^3);
    tof = (1/n)*((e*sinh(H_2) - H_2) - (e*sinh(H_1) - H_1));
end
