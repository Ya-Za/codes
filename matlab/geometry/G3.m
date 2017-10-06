classdef G3 < handle
    %2D geometry
    
    properties
        % - vertices: n-by-3 double matrix
        %   Vertices
        % - faces: m-by-3 int matrix
        %   Faces
        % - color: color
        %   Face color
        
        vertices
        faces
        color
    end
    
    methods
        function obj = G3(vertices, faces, color)
            % Constructor
            
            % default values
            if ~exist('color', 'var')
                color = 'flat';
            end
            
            obj.vertices = vertices;
            obj.faces = faces;
            obj.color = color;
        end
        function plot(obj)
            % Plot
            
            patch(...
                'Vertices', obj.vertices, ...
                'Faces', obj.faces, ...
                'FaceColor', obj.color, ...
                'FaceVertexCData', obj.vertices(:, 1), ...
                'EdgeColor', 'none' ...
            );
        
            axis('equal');
            xlabel('x');
            ylabel('y');
            zlabel('z');
            view(3);
        end
        function transform(obj, T)
            % 3D affine transformation
            
            n = size(obj.vertices, 1);
            V = [obj.vertices, ones(n, 1)];
            V = V * T;
            obj.vertices = V(:, 1:3);
        end
        function scale(obj, sx, sy, sz)
            % 3D scale
            
            obj.transform(G3.scaleMatrix(sx, sy, sz));
        end
        function rotate(obj, ax, a)
            % 2D rotation
            
            obj.transform(G3.rotationMatrix(ax, a));
        end
        function translate(obj, tx, ty, tz)
            % 2D translation
            
            obj.transform(G3.translationMatrix(tx, ty, tz));
        end
    end
    
    methods (Static)
%         function geo = polyline(vertices)
%             % Polyline
%             
%             n = size(vertices, 1);
%             faces = [1:(n - 1); 2:n]';
%             
%             geo = G3(vertices, faces);
%         end
        function geo = polygon(vertices)
            % Polygon
            
            n = size(vertices, 1);
            
            vertices = [vertices, zeros(n, 1)];
            
            faces = [
                ones(1, n - 2)
                2:(n - 1)
                3:n
            ]';
            
            geo = G3(vertices, faces);
        end
        function geo = unitSquare()
            % Unit square
            
            vertices = [
                 0.5  0.5
                -0.5  0.5
                -0.5 -0.5
                 0.5 -0.5
            ];
            
            geo = G3.polygon(vertices);
        end
        function geo = regularPolygon(n)
            % Regular polygon
            
            vertices = zeros(n, 2);
            
            % delta angle
            da = (2 * pi) / n;
            
            a = pi / 2;
            for i = 1:n
                vertices(i, :) = [cos(a), sin(a)];
                a = a + da;
            end
            
            geo = G3.polygon(vertices);
        end
        function geo = unitCircle(n)
            % Unit circle
            
            % default values
            if ~exist('n', 'var')
                n = 100;
            end
            
            geo = G3.regularPolygon(n);
        end
        function T = scaleMatrix(sx, sy, sz)
            % Scale matrix
            
            T = [
                sx 0  0  0
                0  sy 0  0
                0  0  sz 0
                0  0  0  1
            ]';
        end
        function T = rotationMatrix(ax, a)
            % Rotation matrix
            
            s = sin(a);
            c = cos(a);
            t = 1 - c;

            normAx = norm(ax);
            if normAx < eps
                ax = zeros(size(ax));
            else
                ax = ax / normAx;
            end
            
            x = ax(1);
            y = ax(2);
            z = ax(3);
            T = [
                t*x*x + c    t*x*y - s*z  t*x*z + s*y  0
                t*x*y + s*z  t*y*y + c    t*y*z - s*x  0
                t*x*z - s*y  t*y*z + s*x  t*z*z + c    0
                0            0            0            1
            ]';

        end
        function T = translationMatrix(tx, ty, tz)
            % Translation matrix
            
            T = [
                1  0  0  tx
                0  1  0  ty
                0  0  1  tz
                0  0  0  1
            ]';
        end
        function geo = rectangle(w, h)
            % Rectangle
            
            geo = G3.unitSquare();
            geo.scale(w, h, 1);
        end
        function geo = square(s)
            % Square
            
            geo = G3.rectangle(s, s);
        end
        function geo = ellipse(rx, ry)
            % Ellipse
            
            geo = G3.unitCircle();
            geo.scale(rx, ry, 1);
        end
        function geo = circle(r)
            % Circle
            
            geo = G3.ellipse(r, r);
        end
        function geo = prism(shape, z)
            % Prism
            
            n = size(shape.vertices, 1);
            
            % bottom
            vertices = shape.vertices;
            faces = shape.faces(:, [1, 3, 2]);
            
            % up
            vertices = [
                vertices
                [shape.vertices(:, 1:2), shape.vertices(:, 3) + z]
            ];
            faces = [
                faces
                shape.faces + n
            ];
            
            % sides
            for i = 1:(n - 1)
                faces(end + 1, :) = [i, i + 1, i + n + 1];
                faces(end + 1, :) = [i, i + n + 1, i + n];
            end
            faces(end + 1, :) = [n, 1, n + 1];
            faces(end + 1, :) = [n, n + 1, n + n];
            
            
            geo = G3(vertices, faces);
        end
        function [xMin, xMax, yMin, yMax] = boundingBox(shape)
            % Bounding box
            
            xMin = min(shape.vertices(:, 1));
            xMax = max(shape.vertices(:, 1));
            yMin = min(shape.vertices(:, 2));
            yMax = max(shape.vertices(:, 2));
        end
        function [x, y] = center(shape)
            [xMin, xMax, yMin, yMax] = G3.boundingBox(shape);
            
            x = (xMin + xMax) / 2;
            y = (yMin + yMax) / 2;
        end
        function geo = pyramid(shape, z)
            % Pyramid
            
            n = size(shape.vertices, 1);
            
            % base
            vertices = shape.vertices;
            faces = shape.faces(:, [1, 3, 2]);
            
            % apex
            [x, y] = G3.center(shape);
            vertices = [
                vertices
                [x, y, z]
            ];
            
            % sides
            for i = 1:(n - 1)
                faces(end + 1, :) = [i, i + 1, n + 1];
            end
            faces(end + 1, :) = [n, 1, n + 1];
            
            geo = G3(vertices, faces);
        end
        function geo = unitCube()
            % Unit Cube
            
            shape = G3.square(1);
            z = 1;
            
            geo = G3.prism(shape, z);
            
            geo.translate(0, 0, -0.5);
        end
        function geo = box(w, h, d)
            % Box
            
            geo = G3.unitCube();
            
            geo.scale(w, h, d);
        end
        function geo = cube(s)
            % Cube
            
            geo = G3.box(s, s, s);
        end
        function geo = cylinder(r, h)
            % Cylinder
            
            geo = G3.prism(G3.circle(r), h);
            
            geo.translate(0, 0, -h / 2);
        end
        function geo = cone(r, h)
            % Cone
            
            geo = G3.pyramid(G3.circle(r), h);
            
            geo.translate(0, 0, -h / 2);
        end
        function geo = surf(X, Y, Z)
            % Surf
            
            [m, n] = size(X);
            
            % vertices
            vertices = [];
            for i = 1:m
                for j = 1:n
                    vertices(end + 1, :) = [X(i, j), Y(i, j), Z(i, j)];
                end
            end
            
            % faces
            faces = [];
            for i = 1:(m - 1)
                for j = 1:(n - 1)
                    a = (i - 1) * n + j;
                    b = i * n + j;
                    c = b + 1;
                    d = a + 1;
                    
                    faces(end + 1, :) = [a, b, c];
                    faces(end + 1, :) = [a, c, d];
                end
            end
            
            geo = G3(vertices, faces);
        end
        function geo = unitSphere(n)
            % Unit Sphere
            
            % default values
            if ~exist('n', 'var')
                n = 100;
            end
            
            a1 = linspace(0, pi, n);
            a2 = linspace(-pi, pi, n);
            
            Z = cos(a1)' * ones(1, n);
            X = sin(a1)' * cos(a2);
            Y = sin(a1)' * sin(a2);
            
            geo = G3.surf(X, Y, Z);
        end
        function geo = ellipsoid(rx, ry, rz)
            % Ellipsoid
            
            geo = G3.unitSphere();
            
            geo.scale(rx, ry, rz);
        end
        function geo = sphere(r)
            % Sphere
            
            geo = G3.ellipsoid(r, r, r);
        end
        function geo = lathe(points, n)
            % Lathe
            %
            % Parameters
            % ----------
            % - points: m-by-2 double matrix
            %   Input points
            % - n: int
            %   Number of angles
            
            % default values
            if ~exist('n', 'var')
                n = 100;
            end
            
            % vertices
            vertices = [];
            m = size(points, 1);
            points = [points(:, 1), zeros(m, 1), points(:, 2)];
            ax = [0, 0, 1];
            for a = linspace(0, 2 * pi, n)
                R = G3.rotationMatrix(ax, a);
                R = R(1:3, 1:3);
                vertices = [vertices; points * R];
            end
            
            % faces
            faces = [];
            for j = 1:(n - 1)
                for i = 1:(m - 1)
                    a = (j - 1) * m + i;
                    b = a + 1;
                    d = j * m + i;
                    c = d + 1;
                    faces(end + 1, :) = [a, b, c];
                    faces(end + 1, :) = [a, c, d];
                end
            end
            
            geo = G3(vertices, faces);
        end
        function geo = toroid(w, h, r)
            % Toroid
            
            shape = G3.rectangle(w, h);
            shape.translate(r, 0, 0);
            geo = G3.lathe([shape.vertices; shape.vertices(1, :)]);
        end
        function geo = torus(r1, r2)
            % Toroid
            
            shape = G3.circle(r1);
            shape.translate(r2, 0, 0);
            geo = G3.lathe([shape.vertices; shape.vertices(1, :)]);
        end
        function geo = add(geo1, geo2)
            % Add
            
            vertices = [geo1.vertices; geo2.vertices];
            
            n = size(geo1.vertices, 1);
            faces = [geo1.faces; geo2.faces + n];
            
            geo = G3(vertices, faces);
        end
        function geo = grid(D)
            % Grid
            
            wM = 0.02;  % width of major
            dM = 1;     % distance between majors
            wm = 0.01;  % width of minors
            dm = 0.1;   % distance between minors
            
            S = 2 * D + wM; % side of square plane
            
            geo = G3([], []);
            
            % plane
            plane = G3.square(S);
            geo = G3.add(geo, plane);
            
            % majors
            addStrips(dM, wM);
            
            % minors
            addStrips(dm, wm);
            
            % Local Functions
            function addStrips(d, w)
                % vertical
                for x = -D:d:D
                    strip = G3.rectangle(w, S);
                    strip.translate(x, 0, 0);

                    geo = G3.add(geo, strip);
                end

                % horizental
                for y = -D:d:D
                    strip = G3.rectangle(S, w);
                    strip.translate(0, y, 0);

                    geo = G3.add(geo, strip);
                end
            end
        end
        function geo = axes(D)
            % Axes
            
            geo = G3([], []);
            
            % axes
            % - z
            ax = zAxis();
            geo = G3.add(geo, ax);
            
            % - x
            ax = zAxis();
            ax.rotate([0, 1, 0], pi / 2);
            geo = G3.add(geo, ax);
            
            % - y
            ax = zAxis();
            ax.rotate([1, 0, 0], -pi / 2);
            geo = G3.add(geo, ax);
            
            % Local Functions
            function ax = zAxis()
                ax = G3([], []);
                
                % cylinder
                cy.r = 0.1;
                cy.h = 0.7;
                cylinder = G3.cylinder(cy.r, cy.h);
                cylinder.translate(0, 0, cy.h / 2);
                
                ax = G3.add(ax, cylinder);

                % cone
                co.r = 0.2;
                co.h = 0.3;
                cone = G3.cone(co.r, co.h);
                cone.translate(0, 0, cy.h + co.h / 2);
                
                ax = G3.add(ax, cone);
            end
        end
    end
    
end
