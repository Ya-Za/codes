classdef Camera < Plotable
    %Camera
    
    properties
        pos
        right
        up
        forward
    end
    
    methods
        function obj = Camera(pos, lookAt)
            obj.pos = pos;
            
            obj.forward = lookAt - pos;
            obj.forward = obj.forward / norm(obj.forward);
            
            obj.right = cross([0, 1, 0], obj.forward);
            obj.right = obj.right / norm(obj.right);
            
            obj.up = cross(obj.forward, obj.right);
            obj.up = obj.up / norm(obj.up);
        end
        
        function p = points(obj, width, height, sx, sy)
            if ~exist('sx', 'var')
                sx = width;
            end
            if ~exist('sy', 'var')
                sy = height;
            end
            
            p = zeros(height, width, 3);
            
            halfWidth = width / 2;
            halfHeight = height / 2;
            for i = 0:height-1
                for j = 0:width-1
                    x = (j - halfWidth) / sx;
                    y = (-i + halfHeight) / sy;
                    p(i + 1, j + 1, :) = ...
                        obj.pos + ...
                        x * obj.right + ...
                        y * obj.up + ...
                        obj.forward;
                end
            end
        end
        
        function plot(obj)
            ax = Axes(obj.pos, obj.right, obj.up, obj.forward);
            ax.plot();
            
            p = obj.points(10, 10);
            x = p(:, :, 1);
            y = p(:, :, 2);
            z = p(:, :, 3);
            scatter3(x(:), y(:), z(:));
        end
        
    end
    
end

