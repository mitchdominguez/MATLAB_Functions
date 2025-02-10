%% Mitchell Dominguez - doming18@purdue.edu - dcm2quat.m
% Convert a DCM to a quaternion
% INPUTS:
%   nCy = DCM that converts row vector in N to row vector in Y
% OUTPUTS:
%   eps = [e1 e2 e3 e4], where e1-3 are the vector part and e4 is the scalar
function eps = dcm2quat(nCy)
    e4 = 0.5*sqrt(1+nCy(1,1) + nCy(2,2) + nCy(3,3));
    e1 = (nCy(3,2)-nCy(2,3))/(4*e4);
    e2 = (nCy(1,3)-nCy(3,1))/(4*e4);
    e3 = (nCy(2,1)-nCy(1,2))/(4*e4);

    eps_ny_vec = [e1 e2 e3];
    eps_ny_4 = e4;

    eps = [e1 e2 e3 e4];
end
