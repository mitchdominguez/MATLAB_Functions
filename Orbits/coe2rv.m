%% Mitchell Dominguez - coe2rv.m
% Convert classical (keplerian) orbital elements (COEs) into inertial position and velocity
%
% Outputs:
%   x   = struct containing some more data calculated within the function
%
% Inputs:
%   coe = struct containing classical orbital elements [SMA, ECC, AOP, RAAN, INC, TA] (units in deg)
%   mu = gravitational parameter [km3/s2]

function [x] = coe2rv(coe,mu)
    % Convet between using caps orbital elements and lowercase abbreviations
    if ~isfield(coe,'SMA') && isfield(coe,'a')
        coe.SMA = coe.a;
    end
    if ~isfield(coe,'ECC') && isfield(coe,'e')
        coe.ECC = coe.e;
    end
    if ~isfield(coe,'TA') && isfield(coe,'thstar')
        coe.TA = coe.thstar;
    end
    if ~isfield(coe,'AOP') && isfield(coe,'omega')
        coe.AOP = coe.omega;
    end
    if ~isfield(coe,'RAAN') && isfield(coe,'Omega')
        coe.RAAN = coe.Omega;
    end
    if ~isfield(coe,'INC') && isfield(coe,'i')
        coe.INC = coe.i;
    end

    % Assume 3D orbital elements are zero if they are not given
    if ~isfield(coe,'AOP')
        coe.AOP = 0;
    end
    if ~isfield(coe,'RAAN')
        coe.RAAN = 0;
    end
    if ~isfield(coe,'INC')
        coe.INC = 0;
    end

    a = coe.SMA;
    e = coe.ECC;
    thstar = coe.TA;

    % Rotation matrix from rotating to inertial frame
    iCr = rot_rthh2inertial(coe.RAAN,coe.INC,coe.AOP+coe.TA,'deg');

    % Calculate position
    r_mag = r_conic(thstar, a, e, 'deg');
    
    r_R = r_mag*[1; 0; 0];
    r_I = iCr*r_R;

    % Calculate velocity
    v_mag = v_vis_viva(mu, r_mag, a);
    p = a*(1-e^2);
    h_mag = sqrt(mu*p);
    gamma = sign(thstar)*abs(acosd(h_mag/(r_mag*v_mag)));

    v_R = v_mag*[sind(gamma);cosd(gamma); 0];
    v_I = iCr*v_R;

    x.r_mag = r_mag;
    x.v_mag = v_mag;
    x.gamma = gamma;
    x.oe = coe;
    x.iCr = iCr;
    x.r_R = r_R;
    x.r_I = r_I;
    x.v_R = v_R;
    x.v_I = v_I;
end
