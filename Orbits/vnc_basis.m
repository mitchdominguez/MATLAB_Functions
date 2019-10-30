%% Mitchell Dominguez - vnc_basis.m
% Output the basis vectors of the VNC frame, given a position and velocity.
% The output is in the frame that the position and velocity are given in.
%
% Outputs:
%   C = unit vector in the C direction
%   V = unit vector in the V direction
%   N = unit vector in the N direction
% Inputs:
%   r = position vector
%   v = velocity vector

function [C, V, N] = vnc_basis(r,v)
    r_hat = r/norm(r);
    v_hat = v/norm(v);
    V = v_hat;
    N = cross(r_hat,v_hat);
    C = cross(V,N);
end
