%% Mitchell Dominguez - doming18@purdue.edu - jacobi_2d.m
% Calculate Jacobi constant in a 2D system for the CR3BP
% INPUTS:
%   r = position vectors in the rotating frame (m x 2) [ndim]
%   v = velocity vectors in the rotating frame (m x 2) [ndim]
%   mu = mass parameter of system (1 x 1) [ndim] 
% OUTPUTS:
%   C = Jacobi Constant (1 x 1) [ndim]
function C = jacobi_2d(r,v,mu)
    numels = size(v,1);
    dee = sqrt((r(:,1)+mu).^2 + r(:,2).^2);
    arr = sqrt((r(:,1)-1+mu).^2 + r(:,2).^2);
    C = r(:,1).^2 + r(:,2).^2 + 2*(1-mu)./dee + 2*mu./arr - norm3([v,zeros(numels,1)]).^2;
end
