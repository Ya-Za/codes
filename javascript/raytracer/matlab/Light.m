classdef Light < Plotable
    %Light
    
    properties
        pos
        color
        size
    end
    
    methods
        function obj = Light(pos, color, size)
            obj.pos = pos;
            obj.color = color;
            
            if ~exist('size', 'var')
                size = 1;
            end
            obj.size = size;
        end
        
        function plot(obj)
            scatter3(obj.pos(1), obj.pos(2), obj.pos(3), ...
                obj.size * 36, ...
                obj.color, ...
                '*' ...
            );
        end
    end
    
end

