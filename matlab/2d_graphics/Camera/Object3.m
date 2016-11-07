classdef Object3 < handle
    %UNTITLED20 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        points
        colors
    end
    
    methods
        function obj = Object3(points, colors)
            obj.points = points;
            obj.colors = colors;
        end
        
        function draw(obj)
            hold on;
            if obj.is_polyplane()
                Camera3.draw_polyline(obj.points, obj.colors);              
            else
                Camera3.draw_points(obj.points, obj.colors);
            end
            hold off;
        end
        
        function res = is_polyplane(obj)
            if size(obj.points, 2) == 9
                res = true;
            else
                res = false;
            end
        end
    end
    
end

