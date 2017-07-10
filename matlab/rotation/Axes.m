classdef Axes < handle
    %Axes
    
    properties
        % Properties
        % ----------
        % - T: 3-by-4 double matrix
        %   Transformation matrix
        % - R: 3-by-3 double matrix
        %   Rotation matrix
        % - t: 3-by-1 double vector
        %   Translation vector
        % - i: 3-by-1 double vector
        %   `i` unit vector
        % - j: 3-by-1 double vector
        %   `j` unit vector
        % - k: 3-by-1 double vector
        %   `k` unit vector

        T
        
        R
        t
        i
        j
        k
    end
    
    % Constructor
    methods
        function obj = Axes(T)
            if ~exist('T', 'var')
                T = [eye(3), zeros(3, 1)];
            end
            
            obj.T = T;
        end
        
        function value = get.R(obj)
            value = obj.T(1:3, 1:3);
        end
        
        function set.R(obj, value)
            obj.T(1:3, 1:3) = value;
        end
        
        function value = get.t(obj)
            value = obj.T(1:3, 4);
        end
        
        function set.t(obj, value)
            obj.T(1:3, 4) = value(:);
        end
        
        function value = get.i(obj)
            value = obj.T(1:3, 1);
        end
        
        function set.i(obj, value)
            value = value / norm(value);
            obj.T(1:3, 1) = value(:);
        end
        
        function value = get.j(obj)
            value = obj.T(1:3, 2);
        end
        
        function set.j(obj, value)
            value = value / norm(value);
            obj.T(1:3, 2) = value(:);
        end
        
        function value = get.k(obj)
            value = obj.T(1:3, 3);
        end
        
        function set.k(obj, value)
            value = value / norm(value);
            obj.T(1:3, 3) = value(:);
        end
    end
    
    % Transformation
    methods
        function points = toLocal(obj, points)
            points = int(obj.T) * points;
        end
        
        function points = toGlobal(obj, points)
            points = obj.T * points;
        end
        
        function translate(obj, t)
            t = t(:);
            obj.t = obj.t + t;
        end
        
        function rotate(obj, theta, pa)
            % Parameters
            % ----------
            % - pa: char vector
            %   Principal axis, `x`, `y`, `z`
            switch pa
                case 'z'
                    rotateZ(obj, theta);
            end
        end
        
        function rotateZ(obj, theta)
            obj.R = Axes.Rz(theta) * obj.R;
        end
        
        function orbit(obj, origin, direction, angle)
            origin = origin(:);
            direction = direction(:);
            direction = direction / norm(direction);

            % translation
            % todo: `rotation` and `translation` instead of just
            % `translation`
            obj.t = obj.t - origin;
            obj.t = Axes.rotation(direction, angle) * obj.t;
            obj.t = obj.t + origin;
            
            % rotation
            u = origin - obj.t;
            u = u / norm(u);
            
            obj.R = Axes.j2u(u);
        end
        
        function orbitZ(obj, point, theta)
            point = point(:);

            % translation
            obj.t = obj.t - point;
            obj.t = Axes.rotation([0, 0, 1], theta) * obj.t;
            obj.t = obj.t + point;
            
            % rotation
            obj.j = point - obj.t;
            obj.j = obj.j / norm(obj.j);
            forward = [0, 0, 1]';
            obj.i = cross(obj.j, forward);
            obj.k = cross(obj.i, obj.j);
        end
    end
    
    % Plot
    methods
        function plot(obj)
            o = obj.t;
            x = obj.i;
            y = obj.j;
            z = obj.k;
            
            lineWidth = 2;
            % x
            quiver3(...
                o(1), o(2), o(3), ...
                x(1), x(2), x(3), ...
                'Color', 'red', ...
                'LineWidth', lineWidth ...
            );
            hold('on');
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
            hold('off');
        end
    end
    
    % Transformation
    methods (Static)
        function R = Rx(theta)
            t = deg2rad(theta);
            R = [
                1,      0, 0
                0, cos(t), -sin(t)
                0, sin(t), cos(t)
            ];
        end
        
        function R = Ry(theta)
            t = deg2rad(theta);
            R = [
                cos(t) , 0, sin(t)
                0      , 1, 0
                -sin(t), 0, cos(t)
            ];
        end

        function R = Rz(theta)
            t = deg2rad(theta);
            R = [
                cos(t), -sin(t), 0
                sin(t),  cos(t), 0
                0     ,       0, 1
            ];
        end
        
        function R = rotation(u, alpha)
            u(:);
            u = u / norm(u);
            alpha = deg2rad(alpha);

            cosa = cos(alpha);
            sina = sin(alpha);
            vera = 1 - cosa;
            x = u(1);
            y = u(2);
            z = u(3);
            R = [
                cosa+x^2*vera   x*y*vera-z*sina x*z*vera+y*sina; ...
                x*y*vera+z*sina cosa+y^2*vera   y*z*vera-x*sina; ...
                x*z*vera-y*sina y*z*vera+x*sina cosa+z^2*vera ...
            ];
        end
        
        function R = i2u(u)
            u = u(:);
            u = u / norm(u);
            
            i = u;
            up = [0, 1, 0]';
            if all(i == up)
                forward = [0, 0, 1]';
                j = cross(forward, i);
                j = j / norm(j);
                k = cross(i, j);
            else
                k = cross(i, up);
                k = k / norm(k);
                j = cross(k, i);
            end
            
            R = [i, j, k];
        end
        
        function R = j2u(u)
            R = Axes.Rz(90) *  Axes.i2u(u);
        end
        
        function R = k2u(u)
            R = Axes.Ry(90) *  Axes.i2u(u);
        end
        
        function R = rotation2(u, alpha)
            A = Axes.i2u(u);
            R = A * Axes.Rx(alpha) * inv(A);
        end
    end
    
    % Utils
    methods (Static)
        function plotAxis(p0, u, t)
            % p = p0 + ku
            p0 = p0(:);
            u = u(:);
            
            if ~exist('t', 'var')
                t = 10;
            end
            
            points = zeros(3, 2);
            points(:, 1) = p0 - t * u;
            points(:, 2) = p0 + t * u;
            
            hold('on');
            plot3(...
                points(1, :), points(2, :), points(3, :), ...
                'LineStyle', '--' ...
            );
            hold('off');
        end
        
        function h = figure()
            h = figure(...
                'Name', 'Scene', ...
                'NumberTitle', 'off', ...
                'Unit', 'normalized', ...
                'OuterPosition', [0, 0, 1, 1] ...
            );
        end
    end
    
    % Animations
    methods (Static)        
        function animateOrbitZ()
            % Init
            close('all');
            clear();
            clc();
            
            % figure
            Axes.figure();

            % Scene
            limits = [-5, 5];
            % - axes
            ax = Axes();
            % - camera
            camera = Axes();
            camera.translate([2, 2, 2]);

            % - scene
            scene = Scene({ax, camera});

            % Plot
            delay = 0.001;
            angle = 1;
            for i = 1:floor(360 / angle)
                camera.orbit([0, 0, 0], [0, 0, 1], angle);
                
                scene.plot(limits);
                % z axis
                Axes.plotAxis([0, 0, 0], [0, 0, 1], limits(2));
                
                pause(delay);
            end
        end
        
        function animateOrbitAxisOrigin()
            % Init
            close('all');
            clear();
            clc();
            
            % figure
            Axes.figure();

            % Scene
            limits = [-5, 5];
            origin = [0, 0, 0];
            direction = [0, 1, 0];
            % - axes
            ax = Axes();
            % - camera
            camera = Axes();
            camera.translate([2, 2, 2]);

            % - scene
            scene = Scene({ax, camera});

            % Plot
            delay = 0.001;
            angle = 1;
            for i = 1:floor(360 / angle)
                camera.orbit(origin, direction, angle);
                
                scene.plot(limits);
                % z axis
                Axes.plotAxis(origin, direction, limits(2));
                
                pause(delay);
            end
        end
    end
end

