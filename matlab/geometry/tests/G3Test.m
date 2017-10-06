classdef G3Test < matlab.unittest.TestCase
    %Test `G3` class
    
    properties
    end
    
    properties
        originalPath
    end
    
    methods (TestMethodSetup)
        function addToPath(testCase)
            testCase.originalPath = path();
            [parentFolder, ~, ~] = fileparts(pwd);
            addpath(parentFolder);
        end
    end
    
    methods (TestMethodTeardown)
        function restorePath(testCase)
            path(testCase.originalPath);
        end
    end
    
    % todo:
    % - uv2axang(u, v):[ax, ang]
    % - colors in patch
    %   - for each vertex
    %   - for each face
    methods (Test)
        function geometry(testCase)
            % arrange
            vertices = [
                0 0 0
                1 0 0
                1 1 0
                1 0 1
                2 0 1
                2 1 1
            ];
            faces = [
                1 2 3
                4 5 6
            ];
            % act
            geo = G3(vertices, faces);
            figure('Name', 'Geometry');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
%         function polyline(testCase)
%             % arrange
%             vertices = [
%                 0 0
%                 1 1
%                 2 2
%                 3 2
%             ];
%             % act
%             geo = G3.polyline(vertices);
%             figure('Name', 'Polyline');
%             geo.plot();
%             % assert
%             testCase.assertTrue(true);
%         end
        function polygon(testCase)
            % arrange
            vertices = [
                0 0
                1 1
                2 1
                3 0
            ];
            % act
            geo = G3.polygon(vertices);
            figure('Name', 'Polygon');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function unitSquare(testCase)
            % arrange
            % act
            geo = G3.unitSquare();
            figure('Name', 'Unit Square');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function regularPolygon(testCase)
            % arrange
            n = 5;
            % act
            geo = G3.regularPolygon(n);
            figure('Name', 'Regular Polygon');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function unitCircle(testCase)
            % arrange
            % act
            geo = G3.unitCircle();
            figure('Name', 'Unit Circle');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function transform(testCase)
            % arrange
            sx = 2;
            sy = 3;
            sz = 1;
            ax = [0, 0, 1];
            a = pi / 4;
            tx = 3;
            ty = 4;
            tz = 0;
            T = ...
                G3.scaleMatrix(sx, sy, sz) * ...
                G3.rotationMatrix(ax, a) * ...
                G3.translationMatrix(tx, ty, tz);
                
            % act
            geo = G3.unitSquare();
            figure('Name', 'Transform');
            geo.plot();
            hold('on');
            geo.transform(T);
            geo.plot();
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function scale(testCase)
            % arrange
            sx = 2;
            sy = 3;
            sz = 1;
            % act
            geo = G3.unitSquare();
            figure('Name', 'Scale');
            geo.plot();
            hold('on');
            geo.scale(sx, sy, sz);
            geo.translate(0, 0, 1);
            geo.plot();
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function rotate(testCase)
            % arrange
            ax = [0, 0, 1];
            a = pi / 4;
            % act
            geo = G3.unitSquare();
            figure('Name', 'Rotate');
            geo.plot();
            hold('on');
            geo.rotate(ax, a);
            geo.plot();
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function translate(testCase)
            % arrange
            tx = 2;
            ty = 3;
            tz = 1;
            % act
            geo = G3.unitSquare();
            figure('Name', 'Translate');
            geo.plot();
            hold('on');
            geo.translate(tx, ty, tz);
            geo.plot();
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function rectangle(testCase)
            % arrange
            w = 2;
            h = 1;
            % act
            geo = G3.rectangle(w, h);
            figure('Name', 'Rectangle');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function square(testCase)
            % arrange
            s = 2;
            % act
            geo = G3.square(s);
            figure('Name', 'Square');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function ellipse(testCase)
            % arrange
            rx = 2;
            ry = 1;
            % act
            geo = G3.ellipse(rx, ry);
            figure('Name', 'Ellipse');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function circle(testCase)
            % arrange
            r = 2;
            % act
            geo = G3.circle(r);
            figure('Name', 'Circle');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function prism(testCase)
            % arrange
            shape = G3.square(1);
            z = 1;
            % act
            geo = G3.prism(shape, z);
            figure('Name', 'Prism');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function pyramid(testCase)
            % arrange
            shape = G3.square(1);
            z = 1;
            % act
            geo = G3.pyramid(shape, z);
            figure('Name', 'Pyramid');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function unitCube(testCase)
            % arrange
            % act
            geo = G3.unitCube();
            figure('Name', 'Unit Cube');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function box(testCase)
            % arrange
            w = 1;
            h = 2;
            d = 3;
            % act
            geo = G3.box(w, h, d);
            figure('Name', 'Box');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function cube(testCase)
            % arrange
            s = 2;
            % act
            geo = G3.cube(s);
            figure('Name', 'Cube');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function cylinder(testCase)
            % arrange
            r = 2;
            h = 4;
            % act
            geo = G3.cylinder(r, h);
            figure('Name', 'Cylinder');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function cone(testCase)
            % arrange
            r = 2;
            h = 4;
            % act
            geo = G3.cone(r, h);
            figure('Name', 'Cone');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function patch(testCase)
            % arrange
            x = linspace(-pi, pi);
            y = linspace(-pi, pi);
            [X, Y] = meshgrid(x, y);
            Z = sin(X) + cos(Y);
            % act
            geo = G3.surf(X, Y, Z);
            figure('Name', 'Patch');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function unitSphere(testCase)
            % arrange
            % act
            geo = G3.unitSphere();
            figure('Name', 'Unit sphere');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function ellipsoid(testCase)
            % arrange
            rx = 1;
            ry = 2;
            rz = 3;
            % act
            geo = G3.ellipsoid(rx, ry, rz);
            figure('Name', 'Ellipsoid');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function sphere(testCase)
            % arrange
            r = 2;
            % act
            geo = G3.sphere(r);
            figure('Name', 'Sphere');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function lathe(testCase)
            % arrange
            points = [
                0  1
                1  0
                0 -1
            ];
            n = 100;
            % act
            geo = G3.lathe(points, n);
            figure('Name', 'Lathe');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function toroid(testCase)
            % arrange
            w = 1;
            h = 2;
            r = 3;
            % act
            geo = G3.toroid(w, h, r);
            figure('Name', 'Toroid');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function torus(testCase)
            % arrange
            r1 = 1;
            r2 = 3;
            % act
            geo = G3.torus(r1, r2);
            figure('Name', 'Torus');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function add(testCase)
            % arrange
            s = 1;
            r = 1;
            cube = G3.cube(s);
            sphere = G3.sphere(r);
            sphere.translate(0, 0, s);
            % act
            geo = G3.add(cube, sphere);
            figure('Name', 'Add');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function grid(testCase)
            % arrange
            D = 5;
            % act
            geo = G3.grid(D);
            figure('Name', 'Grid');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function axes(testCase)
            % arrange
            D = 3;
            % act
            geo = G3.axes();
            figure('Name', 'Axes');
            geo.plot();
            axis([-D, D, -D, D, -D, D]);
            % assert
            testCase.assertTrue(true);
        end
    end
    
end
