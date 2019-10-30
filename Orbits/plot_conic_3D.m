%% Mitchell Dominguez - plot_conic_3D.m
% Plot a conic section given the Keplerian orbital elements
% Outputs:
%   iCp = rotation matrix from perifocal to inertial frame
%   r_rotated = position of the SC at each given true anomaly
%   f = figure handle for the plotted figure
%   plot_objs = handles to plot objects
% Inputs:
%   thstars = vector defining the true anomalies to plot (given in degrees)
%   SMA = semimajor axis
%   ECC = eccentricity
%   AOP = angle of periapsis
%   RAAN = longitude of the ascending node
%   INC = inclination
%   units = 'rad' or 'deg', specifying units that angular COEs are given in
%   plotstyle = style to plot the orbit in
%   f = figure handle to plot on

function [iCp,r_rotated,f,plot_objs] = plot_conic_3D(thstars, SMA, ECC, AOP, RAAN, INC, units, plotstyle, f)

    % Plot the orbit
    i = 1;
    numpts = length(thstars);
    r_mag = zeros(1,numpts);
    r = zeros(3,numpts);

    p = SMA*(1-ECC^2); % semilatus rectum

    if units == 'deg'
        iCp = rotmataa([0;0;1],RAAN,'deg')*rotmataa([1;0;0],INC,'deg')*rotmataa([0;0;1],AOP,'deg');
        for th_star = thstars
            r_mag(i) = p/(1+ECC*cosd(th_star));
            r(:,i) = r_mag(i)*[cosd(th_star);sind(th_star);0];
            i = i+1;
        end
    else
        for th_star = thstars
            r_mag(i) = p/(1+ECC*cos(th_star));
            r(:,i) = r_mag(i)*[cos(th_star);sin(th_star);0];
            i = i+1;
        end
        iCp = rotmataa([0;0;1],RAAN,'rad')*rotmataa([1;0;0],INC,'rad')*rotmataa([0;0;1],AOP,'rad');
    end

    %c_Om = cosd(RAAN);
    %s_Om = sind(RAAN);
    %c_i = cosd(INC);
    %s_i = sind(INC);
    %c_th = cosd(AOP);
    %s_th = sind(AOP);

    %iCr2 = [c_Om*c_th - s_Om*c_i*s_th, -c_Om*s_th-s_Om*c_i*c_th, s_Om*s_i;
        %s_Om*c_th + c_Om*c_i*s_th, -s_Om*s_th+c_Om*c_i*c_th, -c_Om*s_i;
        %s_i*s_th, s_i*c_th, c_i];

    %iCr == iCr2
    r_rotated = iCp*r;
    
    [minval,mini] = min(r(1,:));
    [maxval,maxi] = max(r(1,:));
    e_hat_scale = 1.2;
    e_hat_endpts = [-abs(SMA)*ECC-e_hat_scale*abs(SMA), -abs(SMA)*ECC+e_hat_scale*abs(SMA);zeros(2)];
    %e_hat = iCr*[r(:,mini), r(:,maxi)];
    e_hat = iCp*e_hat_endpts;

    if nargin == 9
        set(0,'CurrentFigure',f);
        f = f;
    else
        f = figure;
    end
        
    grid on
    hold on
    axis equal
    plot_objs.orbit = plot3(r_rotated(1,:),r_rotated(2,:),r_rotated(3,:),plotstyle,'linewidth',2); % Orbit path
    plot_objs.earth = plot3(0,0,0,'k.', 'markers',30); % Earth
    %[X,Y,Z] = sphere;
    %r_E = 6378.136;
    %surf(r_E.*X, r_E.*Y, r_E.*Z)
    plot_objs.ehat = plot3(1.2*e_hat(1,:), 1.2*e_hat(2,:), 1.2*e_hat(3,:), 'k-', 'linewidth', 1.5);
    %plot(1.2*[min(r(1,:)), max(r(1,:))], [0,0], 'k-', 'linewidth', 1.5) % e hat axis
    %plot([0,0], 1.2*[min(r(2,:)), max(r(2,:))], 'k-', 'linewidth', 1.5) % p hat axis
    axis equal
end
