%% Mitchell Dominguez 2018
% Output a rotation matrix that actively rotates a vector about the
% inputted axis and angle (specify units as 'rad' or 'deg'). Positive
% angles result in a counterclockwise rotation
% INPUTS:
%   v = axis to rotate about
%   th = angle to rotate about v
%   unit = angle units (either 'rad' or 'deg')
% OUTPUTS:
%   R = DCM

function R = rotmataa(v,th,unit)
    v = reshape(v,[],1)/norm(v); % normalize axis
    if strcmp(unit,'deg')
        R = (cosd(th)*eye(3) + (1-cosd(th))*(v*v.') - sind(th)*crs(v)).';
    else
        R = (cos(th)*eye(3) + (1-cos(th))*(v*v.') - sin(th)*crs(v)).';
    end
    
end



