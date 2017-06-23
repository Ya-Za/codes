classdef Plane < Plotable
    %Plane
    
    properties
        point
        normal
        limits
    end
    
    methods
        function obj = Plane(point, normal, limits)
            obj.point = point;
            obj.normal = normal / norm(normal);
            obj.limits = limits;
        end
        
        function plot(obj, n)
            if ~exist('n', 'var')
                n = 20;
            end
            
            % ax + by + cz = d
            a = obj.normal(1);
            b = obj.normal(2);
            c = obj.normal(3);
            d = dot(obj.normal, obj.point);


            if c ~= 0
                x = linspace(obj.limits(1), obj.limits(2), n);
                y = linspace(obj.limits(1), obj.limits(2), n);
                [x, y] = meshgrid(x, y);
                z = (d - a*x - b*y) / c;
            else
                if b ~= 0
                    x = linspace(obj.limits(1), obj.limits(2), n);
                    z = linspace(obj.limits(1), obj.limits(2), n);
                    [x, z] = meshgrid(x, z);
                    y = (d - a*x - c*z) / b;
                else
                    y = linspace(obj.limits(1), obj.limits(2), n);
                    z = linspace(obj.limits(1), obj.limits(2), n);
                    [y, z] = meshgrid(y, z);
                    x = (d - b*y - c*z) / a;
                end
            end

            surf(x, y, z);
        end
    end
    
end

