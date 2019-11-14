%% Mitchell Dominguez - r_conic.m
% Calculate the distance for a given true anomaly, eccentricity, semimajor axis 
% for a conic orbit
%
% Outputs:
%   r = distance between bodies
% 
% Inputs:
%   TA = true anomaly (rad or deg, depending on units), outputs radians if units not specified
%   a = semimajor axis
%   e = eccentricity
%   units = 'rad' or 'deg'

function r = ta_conic(TA,a,e,units)
    p = a*(1-e^2);
    if strcmp(units,'deg')
        r = p/(1+e*cosd(TA));
    else strcmp(units,'rad')
        r = p/(1+e*cos(TA));
    end
end
