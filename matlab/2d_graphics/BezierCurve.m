classdef BezierCurve < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        control_points
        points
    end
    
    methods
        function obj = BezierCurve(control_points)
            obj.control_points = control_points;
            
            obj.run();
        end
        
        function init(obj)
        end
        
        function get_points(obj)                        
            obj.points = [];
            
            for x = obj.control_points(1, 1):obj.control_points(1, 2)
                t = (x - obj.control_points(1, 1)) / (obj.control_points(1, 2) - obj.control_points(1, 1));
                obj.get_points_recursive(obj.control_points, t);
            end
        end
        
        function get_points_recursive(obj, pts, t)
            if size(pts, 2) == 1
                obj.points(:, end + 1) = pts;
                return;
            end
            
            new_pts = [];
            for i = 1:(size(pts, 2) - 1)             
%                 x = round(pts(1, i) + t * (pts(1, i + 1) - pts(1, i)));
%                 y = round(pts(2, i) + t * (pts(2, i + 1) - pts(2, i)));
%                 new_pts(:, end + 1) = [x; y];
                new_pts(:, end + 1) = round((1 - t) * pts(:, i) + t * pts(:, i + 1));
            end
            
            obj.get_points_recursive(new_pts, t);
        end
        
        function plot_points(obj)
            figure;
            scatter(obj.control_points(1, :), obj.control_points(2, :), 100, [1, 0, 0], 'filled');
            hold on;
            plot(obj.points(1, :), obj.points(2, :), 'color', [0, 0, 1]);
            hold off;
        end
        
        function run(obj)
           obj.init();
           
           obj.get_points();
           obj.plot_points();
        end
    end
    
end

