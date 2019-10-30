%% Mitchell Dominguez - plot_conic_2D.m
% Plot a conic section for a given eccentricity, semilatus rectum
% range of true anomalies, and resolution
% Outputs:
%   r = position of the SC at each given true anomaly
%   f = figure handle for the plotted figure
% Inputs:
%   thstars = vector defining the true anomalies to plot (given in degrees)
%   p = semilatus rectum
%   e = eccentricity
%   f = figure handle to plot on

function [r,f] = plot_conic_2D(thstars, p, e, f)

    % Plot the orbit
    i = 1;
    numpts = length(thstars);
    r_mag = zeros(1,numpts);
    r = zeros(3,numpts);

    for th_star = thstars
        r_mag(i) = p/(1+e*cosd(th_star));
        r(:,i) = r_mag(i)*[cosd(th_star);sind(th_star);0];
        i = i+1;
    end

    if nargin == 4
        set(0,'CurrentFigure',f);
    else
        f = figure;
    end
        
    grid on
    hold on
    axis equal
    plot(r(1,:),r(2,:),'k','linewidth',2) % Orbit path
    plot(0,0,'k.', 'markers',30) % Earth
    plot(1.2*[min(r(1,:)), max(r(1,:))], [0,0], 'k-', 'linewidth', 1.5) % e hat axis
    %plot([0,0], 1.2*[min(r(2,:)), max(r(2,:))], 'k-', 'linewidth', 1.5) % p hat axis
    axis equal
end
