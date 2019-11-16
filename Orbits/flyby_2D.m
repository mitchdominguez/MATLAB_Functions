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

    % Get initial values at flyby point
    x_m = pre_flyby_2D(orbit1, planet, sun, ta_sign);

    % planet values at flyby
    v_J_mag = sqrt((sun.mu)/planet.a); % planet speed
    v_J_I = x_m.iCr*[0;v_J_mag;0]; % planet inertial velocity

    % Determine sign for delta
    % Sign changes depending on whether SC leads or trails planet
    if strcmpi('lead',leadtrail)
        LT = +1;
    else
        LT = -1;
    end

    % Sign changes depending on whether SC approaches from within or outside planet orbit
    if dot(x_m.r_I, x_m.v_I) < dot(x_m.r_I, v_J_I) 
        OI = +1;
    else
        OI = -1;
    end

    dsign = LT*OI; % sign of delta

    % Flyby values
    x_h.v_J_mag = v_J_mag;
    x_h.v_J_I = v_J_I;
    x_h.v_inf_m = x_m.v_I - v_J_I; % Hyperbolic excess velocity on entrance [km/s] [3x1]
    x_h.v_inf_mag = norm(x_h.v_inf_m); % Hyperbolic excess speed [km/s]
    x_h.a = -planet.mu/x_h.v_inf_mag^2; % Semimajor axis of hyperbolic orbit [km]
    x_h.e = 1-x_h.r_p/x_h.a; % Eccentricity of flyby
    x_h.delta = 2*dsign*asind(1/x_h.e); % Flyby angle [deg]
    x_h.v_inf_p = rotmataa(z,x_h.delta,'deg')*x_h.v_inf_m; % Hyperbolic excess velocity on exit [km/s] [3x1]

    % Post-flyby values
    x_p.r_mag = x_m.r_mag;
    x_p.r_I = x_m.iCr*x_p.r_mag*x; % position in inertial frame [3x1]
    x_p.v_I = v_J_I + x_h.v_inf_p; % heliocentric velocity after flyby (in inertial frame) [km/s] [3x1]
    x_p.v_mag = norm(x_p.v_I); % heliocentric speed post-flyby
    x_p.carts = rv2coe(x_p.r_I, x_p.v_I, sun.mu);
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
