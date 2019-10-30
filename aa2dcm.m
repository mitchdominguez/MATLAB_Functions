%% Mitchell Dominguez 2018
% Output a rotation matrix that actively rotates a vector about the
% inputted axis and angle (specify units as 'rad' or 'deg'). Positive
% angles result in a counterclockwise rotation
function R = rotmataa(v,th,unit)
    v = v/norm(v); % normalize axis
    if strcmp(unit,'deg')
        R = (cosd(th)*eye(3) + (1-cosd(th))*(v*v.') - sind(th)*crs(v)).';
    else
        R = (cos(th)*eye(3) + (1-cos(th))*(v*v.') - sin(th)*crs(v)).';
    end
    
end



