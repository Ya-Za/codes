classdef Sphere < Plotable
    %Sphere
    
    properties
        center
        radius
    end
    
    methods
        function obj = Sphere(center, radius)
            obj.center = center;
            obj.radius = radius;
        end
        
        function plot(obj, n)
            % 0 <= alpha <= pi, 0 <= beta <= 2pi, 
            % (sin(alpha)cos(beta), sin(alpha)sin(beta), cos(alpha))
            if ~exist('n', 'var')
                n = 20;
            end
            c = obj.center;
            r = obj.radius;
            
            alpha = linspace(0, pi, n);
            beta = linspace(0, 2 * pi, n);
            x = zeros(n, n);
            y = zeros(n, n);
            z = zeros(n, n);
            for i = 1:n
                for j = 1:n
                    z(i, j) = cos(alpha(i));
                    x(i, j) = sin(alpha(i)) * cos(beta(j));
                    y(i, j) = sin(alpha(i)) * sin(beta(j));
                end
            end

            % scale
            x = r * x;
            y = r * y;
            z = r * z;
            % translate
            x = x + c(1);
            y = y + c(2);
            z = z + c(3);
            % plot
            surf(x, y, z);
        end
    end
    
end

