%% Mitchell Dominguez - tof_ellipse.m
% Convert inertial position and velocity into classical (keplerian)
% orbital elements (COEs)
%
% Outputs:
%   tof = time of flight (in seconds)
%
% Inputs:
%   mu = gravitational parameter [km3/s2]
%   a = semimajor axis of orbit [km]
%   e = eccentricity of orbit
%   E_1 = eccentric anomaly at departure [units]
%   E_2 = eccentric anomaly at arrival [units]
%   units = 'deg' or 'rad', specifying units of eccentric anomaly

function tof = tof_ellipse(mu, a, e, E_1, E_2, units)
    n = sqrt(mu/a^3);
    if strcmp(units,'rad')
        tof = (1/n)*((E_2-E_1) - e*sin(E_2) + e*sin(E_1));
    elseif strcmp(units,'deg')
        tof = (1/n)*(deg2rad(E_2-E_1) - e*sind(E_2) + e*sind(E_1));
    end
end
