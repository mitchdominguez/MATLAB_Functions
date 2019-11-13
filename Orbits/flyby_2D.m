%% Mitchell Dominguez - flyby.m
% Calculate the exit velocity of a spacecraft on a hyperbolic
% flyby around a planet
%
% TODO
%   - Check for quadrant for true anomaly and flight path angle
%
% Assumptions:
%   - Distance between the planet and the spacecraft is small relative to the 
%     distance between the spacecraft and the sun
%   - Only the local gravity field of the planet is acting on the spacecraft
%   - Point masses
%   - No atmospheric drag
%
% Outputs:
%   x_m = struct containing information pre-flyby
%   x_h = struct containing information during flyby
%   x_p = struct containing information post-flyby
%
% Inputs:
%   orbit1 = struct containing orbit pre-flyby -- must have fields 'a' and 'e'
%   planet = struct containing flyby planet information -- must have fields 'mu', 'a'
%   sun = struct containing flyby sun information -- must have fields 'mu'
%   flyby_radius = radius to perform flyby at
%   leadtrail = 'lead' if leading or 'trail' if trailing. Default behavior is trailing

function [x_m, x_h, x_p] = flyby(orbit1, planet, sun, flyby_radius, leadtrail, ta_sign)
    define_xyz;
    x_h.r_p = flyby_radius;

    if nargin < 6
        ta_sign = 1;
    end
    ta_sign = ta_sign/abs(ta_sign);

    % Get initial values at flyby point
    x_m.r_mag = planet.a;
    x_m.thstar = ta_sign*ta_conic(x_m.r_mag, orbit1.a, orbit1.e, 'deg'); % initial true anomaly
    x_m.iCr = rot_rthh2inertial(0,0,x_m.thstar,'deg'); % Rotation matrix from rotating frame to inertial frame
    x_m.r_I = x_m.iCr*x_m.r_mag*x; % position in inertial frame [3x1]
    x_m.v_mag = v_vis_viva(sun.mu, x_m.r_mag, orbit1.a); % initial speed
    x_m.gamma = ta_sign*fpa(x_m.r_mag, x_m.v_mag, sun.mu, orbit1.a, orbit1.e, 'deg'); % flight path angle
    x_m.v_R = x_m.v_mag * [sind(x_m.gamma); cosd(x_m.gamma); 0]; % Rotational frame velocity pre-encounter
    x_m.v_I = x_m.iCr*x_m.v_R; % Inertial frame velocity pre-encounter
    x_m.carts = rv2coe(x_m.r_I, x_m.v_I, sun.mu);
    x_m.eps = -sun.mu/(2*x_m.carts.SMA);

    % planet values at flyby
    v_J_mag = sqrt((sun.mu)/planet.a); % planet speed
    v_J_I = x_m.iCr*[0;v_J_mag;0]; % planet inertial velocity

    % Flyby values
    x_h.v_J_mag = v_J_mag;
    x_h.v_J_I = v_J_I;
    x_h.v_inf_m = x_m.v_I - v_J_I; % Hyperbolic excess velocity on entrance [km/s] [3x1]
    x_h.v_inf_mag = norm(x_h.v_inf_m); % Hyperbolic excess speed [km/s]
    x_h.a = -planet.mu/x_h.v_inf_mag^2; % Semimajor axis of hyperbolic orbit [km]
    x_h.e = 1-x_h.r_p/x_h.a; % Eccentricity of flyby
    if nargin >= 5 && strcmp('lead',leadtrail)
        x_h.delta = -2*ta_sign*asind(1/x_h.e); % Flyby angle [deg]
    else
        x_h.delta = 2*ta_sign*asind(1/x_h.e); % Flyby angle [deg]
    end
    x_h.v_inf_p = rotmataa(z,x_h.delta,'deg')*x_h.v_inf_m; % Hyperbolic excess velocity on exit [km/s] [3x1]

    % Post-flyby values
    x_p.r_mag = x_m.r_mag;
    x_p.r_I = x_m.iCr*x_p.r_mag*x; % position in inertial frame [3x1]
    x_p.v_I = v_J_I + x_h.v_inf_p; % heliocentric velocity after flyby (in inertial frame) [km/s] [3x1]
    x_p.v_mag = norm(x_p.v_I); % heliocentric speed post-flyby
    x_p.carts = rv2coe(x_p.r_I, x_p.v_I, sun.mu);
    %x_p.carts2 = cart2kep_mitch([x_p.r_I; x_p.v_I], sun.mu);
    x_p.a = x_p.carts.SMA;
    x_p.e = x_p.carts.ECC;
    x_p.gamma = sign(x_p.carts.TA)*abs(fpa(x_p.r_mag, x_p.v_mag, sun.mu, x_p.a, x_p.e, 'deg')); % flight path angle
    x_p.r_p = x_p.a*(1-x_p.e);
    x_p.r_a = x_p.a*(1+x_p.e);
    x_p.eps = -sun.mu/(2*x_p.carts.SMA);
    x_p.carts.AOP = x_m.thstar - x_p.carts.TA;

    % More flyby values
    x_h.dv_eq = x_p.v_I-x_m.v_I;
    x_h.alpha = sign(x_p.gamma-x_m.gamma)*abs(acosd(dot(x_h.dv_eq, x_m.v_I)/norm(x_h.dv_eq)/norm(x_m.v_I)));
end
