%% Mitchell Dominguez - coe2rv.m
% Convert classical (keplerian) orbital elements (COEs) into inertial position and velocity
%
% Outputs:
%   r_I = inertial frame position vector [km/s] [3x1]
%   v_I = inertial frame velocity vector [km/s] [3x1]
%   r_R = rotating frame position vector [km/s] [3x1]
%   v_R = rotating frame velocity vector [km/s] [3x1]
%
% Inputs:
%   coe = struct containing classical orbital elements [SMA, ECC, AOP, RAAN, INC, TA] (units in deg)
%   mu = gravitational parameter [km3/s2]

function [r_I, v_I, r_R, v_R] = rv2coe(coe,mu)
    a = coe.SMA;
    e = coe.ECC;
    thstar = coe.TA;

    % Rotation matrix from rotating to inertial frame
    iCr = rot_rthh2inertial(coe.RAAN,coe.INC,coe.AOP+coe.TA);

    % Calculate position
    r_mag = r_conic(thstar, a, e, 'deg');
    
    r_R = r_mag*[cosd(thstar); sind(thstar); 0];
    r_I = iCr*r_R;

    % Calculate velocity
    v_mag = v_vis_viva(mu, r_mag, a);
    p = a*(1-e^2);
    h_mag = sqrt(mu*p);
    gamma = sign(thstar)*abs(acosd(h_mag/(r_mag*v_mag)));

    v_R = v_mag*[sind(thstar);cosd(thstar); 0];
    v_I = iCr*v_R;
end
