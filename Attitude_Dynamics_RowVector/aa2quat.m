%% Mitchell Dominguez - doming18@purdue.edu - aa2quat.m
% Take in an axis and an angle and convert to a column vector
% of Euler parameters, with the scalar part as the 4th element
%
% INPUTS:
%   lam = 3-vector representing rotation axis
%   th = angle to rotate about
%   unit = angle to rotate about
%
% OUTPUTS:
%   eps = 4-vector representing Euler parameters of given rotation [4x1]

function eps = aa2quat(lam,th,unit)
    lam = lam/norm(lam); % normalize axis
    lam = lam(:);
    if strcmp(unit,'deg')
        eps = [lam*sind(th/2);cosd(th/2)];
    else
        eps = [lam*sin(th/2);cos(th/2)];
    end


end
