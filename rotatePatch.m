%% Mitchell Dominguez 2018
% Rotate a patch object's vertices
% INPUTS:
%   v:       original patch object
%   R:          3x3 rotation matrix
% OUTPUTS:
%   rotated:    rotated patch object
function v = rotatePatch(v,R)
[r,~] = size(v); % Find number of rows in v
for i = 1:r
    v(i,:) = (R*v(i,:).').';
end
end