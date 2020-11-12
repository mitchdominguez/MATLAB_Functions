%% Mitchell Dominguez - plotvec.m
% Plot a vector from start point to stop point

function plot_obj = plotvec(start, stop,varargin)
    %disp(varargin)
    plot_obj = 1;
    if size(start) ~= size(stop)
        disp('Start and stop points must be of the same dimension')
    end
    if length(start)==2
        % 2d plot
        plot_obj = plot([start(1), stop(1)],[start(2), stop(2)],varargin{:});
    else
        % 3d plot
        plot_obj = plot3([start(1), stop(1)],[start(2), stop(2)],[start(3), stop(3)],varargin{:});
    end
end
