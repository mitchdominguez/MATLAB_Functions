%% Mitchell Dominguez - ta_conic.m
% Calculate the true anomaly for a given distance, eccentricity, semimajor axis 
% for a conic orbit
%
% NOTE THAT THIS DOES NOT CHECK FOR CORRECT SIGN
%
% Outputs:
%   TA = true anomaly (rad or deg, depending on units), outputs radians if units not specified
% 
% Inputs:
%   r = distance between bodies
%   a = semimajor axis
%   e = eccentricity
%   units = 'rad' or 'deg'

function TA = ta_conic(r,a,e,units)
    p = a*(1-e^2);
    if strcmp(units,'deg')
        TA = acosd((1/e)*(p/r - 1));
    else strcmp(units,'rad')
        TA = acos((1/e)*(p/r - 1));
    end
end
