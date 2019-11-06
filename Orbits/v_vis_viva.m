%% Mitchell Dominguez - v_vis_viva.m
% Use the vis-viva equation to calculate the velocity of a body on a 
% Keplerian orbit
%
% Outputs:
%   v = relative speed of bodies [km/s]
%
% Inputs:
%   mu = gravitational parameter [km3/s2]
%   r = relative position of the bodies [km]
%   a = semimajor axis [km]

function v = v_vis_viva(mu,r,a)
    v = sqrt(mu*(2/r - 1/a));
end
