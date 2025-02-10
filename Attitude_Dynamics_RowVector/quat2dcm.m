%% Mitchell Dominguez - doming18@purdue.edu - quat2dcm.m
% Convert Euler parameters (quaternions) to a DCM (that uses row vectors)
% INPUTS:
%   eps: eps1-3 are the vector part, eps4 is the scalar part [1x4]
% OUTPUTS:
%   aCb: DCM [3x3]

function aCb = quat2dcm(eps)
    e1 = eps(1);
    e2 = eps(2);
    e3 = eps(3);
    e4 = eps(4);
    aCb = [1-2*e2^2 - 2*e3^2, 2*(e1*e2 - e3*e4), 2*(e3*e1 + e2*e4);
           2*(e1*e2 + e3*e4), 1-2*e3^2 - 2*e1^2, 2*(e2*e3 - e1*e4);
           2*(e3*e1 - e2*e4), 2*(e2*e3 + e1*e4), 1-2*e1^2 - 2*e2^2];
end
