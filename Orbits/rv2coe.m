%% Mitchell Dominguez - rv2coe.m
% Convert inertial position and velocity into classical (keplerian)
% orbital elements (COEs)
%
% Outputs:
%   coe = struct containing classical orbital elements [SMA, ECC, AOP, RAAN, INC, TA, TH]
%
% Inputs:
%   r = inertial position vector [km/s] [3x1]
%   v = inertial velocity vector [km/s] [3x1]
%   mu = gravitational parameter [km3/s2]

function coe = rv2coe(r,v,mu)

    % Calculate magnitude of r
    r_mag = norm(r);

    % Calculate magnitude of v
    v_mag = norm(v);

    % Calculate a
    a = -mu/(v_mag^2 - 2*mu/r_mag);

    % Calculate e
    h = cross(r,v);
    h_mag = norm(h);
    h_hat = h/h_mag;
    e = sqrt(1-h_mag^2/(mu*a));

    % Calculate i
    i = abs(wrapTo180(acosd(h_hat(3))));

    % Calculate Omega
    %Omega = atan2d(h_hat(1)/sind(i),-h_hat(2)/sind(i))
    Omega = atan2d(h(1), -h(2));

    % Calculate thstar
    r_hat = r/r_mag;
    th_hat = cross(h_hat,r_hat);
    p = a*(1-e^2);

    thstar_init = abs(acosd((p/r_mag-1)/e));
    if dot(v,r_hat) > 0
        thstar = thstar_init;
    else
        thstar = -thstar_init;
    end

    %if isnan(thstar)
        %disp('WARNING: TA WAS NAN')
        %thstar = 0;
    %end

    % Calculate omega
    %r_hat
    %th_hat
    th = atan2d(r_hat(3)/sind(i), th_hat(3)/sind(i));
    th = atan2d(r_hat(3), th_hat(3));
    %if isnan(th)
        %disp('WARNING: TH WAS NAN')
        %th = 0;
    %end

    omega = th-thstar;
    %if isnan(omega)
        %disp('WARNING: AOP WAS NAN')
        %omega = 0;
    %end


    coe.SMA = a;
    coe.ECC = e;
    coe.AOP = omega;
    coe.RAAN = Omega;
    coe.TA = thstar;
    coe.INC = i;
    coe.TH = th;
end
