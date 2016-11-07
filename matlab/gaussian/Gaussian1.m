classdef Gaussian1 < handle
    %Gaussian1 simulates 1d gaussian
    
    properties
        xlimits
        number_of_points
        mu
        sigma
        h_fig
        h_ax
        h_line
    end
    
    methods
        function obj = Gaussian1()
            obj.xlimits = [-10, 10];
            obj.number_of_points = 1000;
            obj.mu = 0;
            obj.sigma = 1;
            
            obj.h_fig = figure('Name', '1-D Gaussian', 'NumberTitle', 'off', 'Units', 'normalized', 'OuterPosition', [0.25, 0.25, 0.5, 0.5]);
            obj.h_ax = axes(obj.h_fig);
            
            obj.init();
        end
        
        function init(obj)
            x = linspace(obj.xlimits(1), obj.xlimits(2), obj.number_of_points);
            obj.h_line = plot(...
                obj.h_ax, ...
                x, ...
                normpdf(x, obj.mu, obj.sigma), ...
                'LineWidth', 2 ...
            );
            
            xlim(obj.h_ax, obj.xlimits);
            ylim(obj.h_ax, [0, 2]);
            grid(obj.h_ax, 'on');
            grid(obj.h_ax, 'minor');
        end
        
        function update(obj)
            obj.h_line.YData = normpdf(obj.h_line.XData, obj.mu, obj.sigma);
            title(obj.h_ax, sprintf('\\mu: %.2f, \\sigma: %.2f', obj.mu, obj.sigma));
        end
    end
    
end

