%% Mitchell Dominguez 2018
% Translate a patch object's vertices
% INPUTS:
%   v:          original patch object
%   t:          translation of the patch object (3x1)
% OUTPUTS:
%   rotated:    rotated patch object
function v = translatePatch(v,t)
t = reshape(t,1,3);
v = v+t;
end