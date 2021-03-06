classdef Axes < Plotable
    %Axes
    
    properties
        origin
        i
        j
        k
    end
    
    methods
        function obj = Axes(origin, i, j, k)
            obj.origin = origin;
            obj.i = i / norm(i);
            obj.j = j / norm(j);
            obj.k = k / norm(k);
        end
        
        function plot(obj)
            o = obj.origin;
            x = obj.i;
            y = obj.j;
            z = obj.k;
            
            hold('on');
            lineWidth = 2;
            % x
            quiver3(...
                o(1), o(2), o(3), ...
                x(1), x(2), x(3), ...
                'Color', 'red', ...
                'LineWidth', lineWidth ...
            );
            % x
            quiver3(...
                o(1), o(2), o(3), ...
                y(1), y(2), y(3), ...
                'Color', 'green', ...
                'LineWidth', lineWidth ...
            );
            % x
            quiver3(...
                o(1), o(2), o(3), ...
                z(1), z(2), z(3), ...
                'Color', 'blue', ...
                'LineWidth', lineWidth ...
            );
        end
    end
    
    methods (Static)
        function test()
            ax = Axes(...
                [1.0, 1.0, 1.0], ...
                [1.0, 0.0, 0.0], ...
                [0.0, 1.0, 0.0], ...
                [0.0, 0.0, 1.0] ...
            );
            
            ax.plot();
            axis('equal');
        end
    end
end

