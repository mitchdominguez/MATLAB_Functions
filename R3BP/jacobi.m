%% Mitchell Dominguez - doming18@purdue.edu - jacobi.m
% Calculate Jacobi constant in a 2D system for the CR3BP
% INPUTS:
%   r = position vectors in the rotating frame (m x 3) [ndim]
%   v = velocity vectors in the rotating frame (m x 3) [ndim]
%   mu = mass parameter of system (1 x 1) [ndim] 
% OUTPUTS:
%   C = Jacobi Constant (m x 1) [ndim]
function C = jacobi(r,v,mu)
    dee = sqrt((r(:,1)+mu).^2 + r(:,2).^2 + r(:,3).^2);
    arr = sqrt((r(:,1)-1+mu).^2 + r(:,2).^2 + r(:,3).^2);
    C = r(:,1).^2 + r(:,2).^2 + 2*(1-mu)./dee + 2*mu./arr - norm3(v).^2;
end
