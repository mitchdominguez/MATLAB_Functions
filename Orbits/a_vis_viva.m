%% Mitchell Dominguez - a_vis_viva.m
% Use the vis-viva equation to calculate the semimajor axis of a body on a 
% Keplerian orbit
%
% Outputs:
%   a = semimajor axis [km]
%
% Inputs:
%   mu = gravitational parameter [km3/s2]
%   r = relative position of the bodies [km]
%   v = relative speed of bodies [km/s]

function a = v_vis_viva(mu,r,v)
    a = -mu/(v^2 - 2*mu/r);
end
