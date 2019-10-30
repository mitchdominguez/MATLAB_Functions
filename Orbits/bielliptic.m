%% Mitchell Dominguez - bielliptic.m
% Calculate a bielliptic transfer between two circular orbits,
% or two elliptical orbits with the same periapsis direction. 
% This can be a Hohmann transfer if intermediate radius is the 
% same as the final radius. Inclination changes are accomplished 
% during the intermediate burn (at apoapsis).
% Assumptions:
%   -departure burn is done at zero true anomaly (at periapsis)
%   -initial and final orbit have the same RAAN 
% 
% Outputs:
%   dv1 = delta v vector for departure burn [km/s]
%   dv2 = delta v vector for intermediate burn [km/s]
%   dv3 = delta v vector for final burn [km/s]
%   states = orbital states before and after each burn [r;v] (in inertial coordinates)
%   tof = 2x1 vector containing time of flight on each intermediate trajectory [s]
% Inputs:
%   orbit1 = struct containing orbital elements of the initial orbit [SMA, ECC, INC]
%   orbit2 = struct containing orbital elements of the final orbit [SMA, ECC, INC]
%   RAAN = longitude of the ascending node of the orbits
%   r_i = intermediate radius [km]
%   mu = gravitational parameter [km3/s2]

function [dv1, dv2, dv3, states, tof, alpha, beta] = bielliptic(orbit1, orbit2, RAAN, r_i, mu)

    %% Unpack inputs
    a_1 = orbit1.SMA;
    e_1 = orbit1.ECC;
    i_1 = orbit1.INC;
    a_2 = orbit2.SMA;
    e_2 = orbit2.ECC;
    i_2 = orbit2.INC;

    %% Determine if this is a Hohmann transfer
    if r_i == a_2*(1+e_2) && i_1 == i_2 % Hohmann Transfer case
        hohmann = true;
        disp('This is a Hohmann transfer')
    else
        hohmann = false;
        disp('This is a Bielliptic transfer')
    end


    %% First Maneuver
    % Calculate intermediate SMAs
    r_1 = a_1*(1-e_1);
    if hohmann % Hohmann Transfer case
        r_2 = a_2*(1+e_2);
    else
        r_2 = a_2*(1-e_2);
    end
    a_t1 = 0.5*(r_1 + r_i);
    a_t2 = 0.5*(r_2 + r_i);

    % Calculate v1_m
    v1_m_mag = sqrt(mu/r_1);
    iCr_1 = rot_rthh2inertial(RAAN,i_1,0,'deg');
    v1_m = iCr_1*[0;v1_m_mag;0];
    states.m1 = [r_1;0;0;v1_m];

    % Calculate v1_p
    v1_p_mag = sqrt(2*mu/r_1 - mu/a_t1);
    v1_p = iCr_1*[0;v1_p_mag;0];
    states.p1 = [r_1;0;0;v1_p];

    % Calculate dv1
    dv1 = v1_p - v1_m;

    % Calculate alpha, beta
    [alpha1, beta1] = calc_3D_alpha_beta(states.p1(1:3),states.p1(4:6), dv1);

    %% Second Maneuver
    % Calculate v2_m
    v2_m_mag = sqrt(2*mu/r_i - mu/a_t1);
    iCr_2_m = rot_rthh2inertial(RAAN,i_1,180,'deg');
    v2_m = iCr_2_m*[0;v2_m_mag;0];
    states.m2 = [-r_i;0;0;v2_m];

    % Calculate v2_p
    v2_p_mag = sqrt(2*mu/r_i - mu/a_t2);
    iCr_2_p = rot_rthh2inertial(RAAN,i_2,180,'deg');
    v2_p = iCr_2_p*[0;v2_p_mag;0];
    states.p2 = [-r_i;0;0;v2_p];

    % Calculate dv2
    dv2 = v2_p - v2_m;

    % Calculate alpha, beta
    [alpha2, beta2] = calc_3D_alpha_beta(states.p2(1:3),states.p2(4:6),dv2);

    % Calculate TOF
    tof(1,1) = pi*sqrt(a_t1^3/mu);

    %% Third maneuver
    % Calculate v3_m
    v3_m_mag = sqrt(2*mu/r_2 - mu/a_t2);
    iCr_3 = rot_rthh2inertial(RAAN,i_2,0,'deg');
    v3_m = iCr_3*[0;v3_m_mag;0];
    states.m3 = [r_2;0;0;v3_m];
    
    % Calculate v3_p
    v3_p_mag = sqrt(mu/r_2);
    v3_p = iCr_3*[0;v3_p_mag;0];
    states.p3 = [r_2;0;0;v3_p];

    % Calculate dv3
    dv3 = v3_p - v3_m;

    if hohmann % Case that this is a Hohmann transfer
        tof(2,1) = 0;
        alpha = [alpha1;alpha2];
        beta = [beta1;beta2];
    else
        tof(2,1) = pi*sqrt(a_t2^3/mu);

        % Calculate alpha, beta
        [alpha3, beta3] = calc_3D_alpha_beta(states.p3(1:3),states.p3(4:6),dv3);
        alpha = [alpha1;alpha2;alpha3];
        beta = [beta1;beta2;beta3];
    end

end
