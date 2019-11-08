%% Mitchell Dominguez - fpa.m
% Calculate the flight path angle of a keplerian orbit 
%
% NOTE THAT THIS DOES NOT CHECK FOR CORRECT SIGN
%
% Outputs:
%   FPA = flight path angle (rad or deg, depending on units), outputs radians if units not specified
% 
% Inputs:
%   r = distance between bodies [km]
%   v = relative speed between bodies [km/s]
%   mu = gravitational parameter [km3/s2]
%   a = semimajor axis [km]
%   e = eccentricity
%   units = 'rad' or 'deg'

function FPA = fpa(r,v,mu,a,e,units)
    p = a*(1-e^2);
    if abs(ta_conic(r,a,e,'deg')-180) <= 1e-12 || abs(ta_conic(r,a,e,'deg')) <= 1e-12 
        FPA = 0;
        return
    end
    if strcmp(units,'deg')
        sqrt(mu*p)/(r*v)
        FPA = acosd(sqrt(mu*p)/(r*v));
    else strcmp(units,'rad')
        FPA = acos(sqrt(mu*p)/(r*v));
    end
end
