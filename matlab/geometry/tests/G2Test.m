classdef G2Test < matlab.unittest.TestCase
    %Test `G2` class
    
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
    % - bazier
    % - spline
    % - polybool
    
    % Computational geometry
    methods (Test)
        function eq(testCase)
            % arrange
            p1 = [0, 1];
            p2 = [0, 1.0001];
            
            expected = true;
            % act
            actual = G2.eq(p1, p2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function getLine(testCase)
            % arrange
            p1 = [0, 0];
            p2 = [0, 1];
            
            expected = [-1, 0, 0];
            % act
            actual = G2.getLine(p1, p2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function getNearestPointOnLine(testCase)
            % arrange
            p = [0, 1];
            p1 = [-1, 0];
            p2 = [1, 0];
            expected = [0, 0];
            % act
            actual = G2.getNearestPointOnLine(p, p1, p2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function intersectionOfTwoLines(testCase)
            % arrange
            p1 = [0, 0];
            p2 = [1, 1];
            q1 = [2, 0];
            q2 = [2, 1];

            expected = [2, 2];
            % act
            actual = G2.intersectionOfTwoLines(p1, p2, q1, q2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function boundingBox(testCase)
            % arrange
            points = [
                1, 0
                1, 1
                0, 0.5
                -1, 1
                -1, 0
            ];
            expected = [-1, 1, 0, 1];
            % act
            [actual(1), actual(2), actual(3), actual(4)] = ...
                G2.boundingBox(points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function inBox(testCase)
            % arrange
            p = [1, 1];
            points = [
                0, 0
                2, 2
            ];
            expected = true;
            % act
            actual = G2.inBox(p, points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function intersectionOfTwoSegments(testCase)
            % arrange
            p1 = [0, 0];
            p2 = [1, 1];
            q1 = [1, 0];
            q2 = [0, 1];
            
            expected = [0.5, 0.5];
            % act
            actual = G2.intersectionOfTwoSegments(p1, p2, q1, q2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function pointOnLine(testCase)
            % arrange
            q = [2, 2];
            p1 = [0, 0];
            p2 = [1, 1];
            
            expected = true;
            % act
            actual = G2.pointOnLine(q, p1, p2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function pointOnSegment(testCase)
            % arrange
            q = [0.5, 0.5];
            p1 = [0, 0];
            p2 = [1, 1];
            
            expected = true;
            % act
            actual = G2.pointOnSegment(q, p1, p2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function signOfCross(testCase)
            % arrange
            u1 = [1, 0];
            u2 = [0, 1];
            expected = +1;
            % act
            actual = G2.signOfCross(u1, u2);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function signOfPolygon(testCase)
            % arrange
            points = [
                1, 0
                0, 1
                -1, 0
            ];
            expected = +1;
            % act
            actual = G2.signOfPolygon(points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function convexHull(testCase)
            % arrange
            S = [
                0 -1
                1 0
                0 1
                -2 0
                0 -2
                0 2
                2 0
            ];
            expected = [
                2 0
                0 2
                -2 0
                0 -2
            ];
            % act
            actual = ...
                G2.convexHull(S);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function isConvex(testCase)
            % arrange
            points = [
                1, 0
                1, 1
                0, 0.5
                -1, 1
                -1, 0
            ];
            expected = false;
            % act
            actual = G2.isConvex(points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function pointOnPolygon(testCase)
            % arrange
            poly = [
                1, 0
                0, 1
                -1, 0
                0, -1
            ];
            point = [-1, 0];
            expected = true;
            % act
            actual = G2.pointOnPolygon(point, poly);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function evenOdd(testCase)
            % arrange
            poly = [
                2, 0
                1, 0
                0, 1
                -1, 0
                0, -1
            ];
            points = [
                0, 0
                -2, 0
                -1, 0
                1, 0
                2, 0
            ];
            expected = [true, false, true, true, true]';
            % act
            actual = G2.evenOdd(poly, points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function nonZero(testCase)
            % arrange
            poly = [
                2, 0
                1, 0
                0, 1
                -1, 0
                0, -1
            ];
            points = [
                0, 0
                -2, 0
                -1, 0
                1, 0
                2, 0
            ];
            expected = [true, false, true, true, true]';
            % act
            actual = G2.nonZero(poly, points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function earClipping(testCase)
            % arrange
            points = [
                0, 0
                1, 0
                0.2, 0.2
                1, 1
                0, 1
            ];
            % act
            triangles = G2.earClipping(points);
            G2.plotPolygons(triangles);
            % assert
            testCase.assertTrue(true);
        end
        function voronoi(testCase)
            % arrange
            points = [
                0, 0
                2, 0
                1, 1
            ];
            % act
            polygons = G2.voronoi(points);
            G2.plotPolygons(polygons);
            hold('on');
            scatter(points(:, 1), points(:, 2), 'r*');
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function planarGraph(testCase)
            % arrange
            points = [
                0, 0
                1, 0
                1, 1
                0, 1
            ];
%             points = [
%                 0 0
%                 1 0
%                 2 0
%             ];
            expected.adjacency = logical([
                0   1   1   1
                1   0   1   0
                1   1   0   1
                1   0   1   0
            ]);
            expected.edges = [
                2, 1
                3, 1
                3, 2
                4, 1
                4, 3
            ];
            % act
            [actual.adjacency, actual.edges] = G2.planarGraph(points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function triangulateFromPlanarGraphB(testCase)
            % arrange
            points = [
                0, 0
                1, 0
                1, 1
                0, 1
            ];
            % act
            [adjacency, ~] = G2.planarGraph(points);
            triangles = G2.triangulateFromPlanarGraphB(adjacency);
            G2.plotTriangles(points, triangles);
            % assert
            testCase.assertTrue(true);
        end
        function triangulateFromPlanarGraph(testCase)
            % arrange
            points = [
                0, 0
                1, 0
                1, 1
                0, 1
            ];
            % act
            [adjacency, edges] = G2.planarGraph(points);
            triangles = G2.triangulateFromPlanarGraph(adjacency, edges);
            G2.plotTriangles(points, triangles);
            % assert
            testCase.assertTrue(true);
        end
        function delaunay(testCase)
            % arrange
%             points = [
%                 0, 0
%                 1, -2
%                 2, 0
%                 1, 2
%             ];
            points = [
                0, 0
                1, -0.5
                2, 0
                1, 0.5
            ];
            % act
            triangles = G2.delaunay(points);
            G2.plotTriangles(points, triangles);
            hold('on');
            scatter(points(:, 1), points(:, 2), 'r*');
            hold('off');
            axis('equal');
            % assert
            testCase.assertTrue(true);
        end
        function selfIntersectingToSimple(testCase)
            % arrange
            points = [
               -2.3850   -2.3320
               -0.2420    3.6440
                1.9930   -2.3620
               -3.0530    1.5740
                2.2930    1.8660
            ];
            % act
            points = G2.selfIntersectingToSimple(points);
            G2.plotPolygon(points);
            % assert
            testCase.assertTrue(true);
        end
        function correctPointsWithHoles(testCase)
            % arrange
            points = [
               0 0
               1 1
               NaN NaN
               2 2
               3 3
            ];
            expected = [
                0 0
                1 1
                0 0
                NaN NaN
                2 2
                3 3
                2 2
                NaN NaN
            ];
            % act
            actual = G2.correctPointsWithHoles(points);
            % assert
            testCase.assertEqual(actual, expected);
        end
        function polygonTriangulate(testCase)
            % arrange
            % - convex
%             points = [
%                 0 0
%                 1 0
%                 1 1
%                 0 1
%             ];
%             points = [
%                 0 0
%                 1 2
%                 0 3
%                 -1 1
%             ];
%             points = [
%                -2.2000   -2.3320
%                 0.2650   -4.2570
%                 2.7530   -0.5830
%                 2.4540    2.1570
%                -0.5410    4.4900
%                -3.2830    0.7580
%             ];
            
            % - concave
%             points = [
%                -2.8000   -0.0290
%                -1.4630   -2.2740
%                -1.0710   -1.2240
%                 0.1040   -2.9450
%                 1.6710   -0.4080
%                 0.7260    2.4200
%                 0.2420    0.7290
%                -1.9010    3.9070
%                -1.9470    0.2620
%                -2.5460    1.0200
%             ];
%             points = [
%                -3.4680   -1.1660
%                -0.7490   -4.3440
%                 2.1310    2.2160
%                -0.7950    0.0870
%                -2.9610    1.9830
%             ];
%             points = [
%                 0 0
%                 1 2
%                 0 1
%                 -1 2
%             ];
            
            % - self-intersecting
%             points = [
%                -2.3850   -2.3320
%                -0.2420    3.6440
%                 1.9930   -2.3620
%                -3.0530    1.5740
%                 2.2930    1.8660
%             ];
            points = [
               0 0
               1 1
               0 1
               1 0
            ];
        
            % act
            [triangles, points] = G2.polygonTriangulate(points);
            G2.plotTriangles(points, triangles);
            hold('on');
            scatter(points(:, 1), points(:, 2), 'r*');
            hold('off');
            axis('equal');
            % assert
            testCase.assertTrue(true);
        end
    end
    
    methods (Test)
        function geometry(testCase)
            % arrange
            vertices = [
                0 0
                1 1
                2 2
                3 2
            ];
            faces = [
                1 2
                3 4
            ];
            % act
            geo = G2(vertices, faces);
            figure('Name', 'Geometry');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function polyline(testCase)
            % arrange
            vertices = [
                0 0
                1 1
                2 2
                3 2
            ];
            % act
            geo = G2.polyline(vertices);
            figure('Name', 'Polyline');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function polygon(testCase)
            % arrange
            vertices = [
                0 0
                1 1
                2 2
                3 2
            ];
            % act
            geo = G2.polygon(vertices);
            figure('Name', 'Polygon');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function unitSquare(testCase)
            % arrange
            % act
            geo = G2.unitSquare();
            figure('Name', 'Unit Square');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function regularPolygon(testCase)
            % arrange
            n = 5;
            % act
            geo = G2.regularPolygon(n);
            figure('Name', 'Regular Polygon');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function unitCircle(testCase)
            % arrange
            % act
            geo = G2.unitCircle();
            figure('Name', 'Unit Circle');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function transform(testCase)
            % arrange
            sx = 2;
            sy = 3;
            a = pi / 4;
            tx = 3;
            ty = 4;
            T = ...
                G2.scaleMatrix(sx, sy) * ...
                G2.rotationMatrix(a) * ...
                G2.translationMatrix(tx, ty);
                
            % act
            geo = G2.unitSquare();
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
            % act
            geo = G2.unitSquare();
            figure('Name', 'Scale');
            geo.plot();
            hold('on');
            geo.scale(sx, sy);
            geo.plot();
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function rotate(testCase)
            % arrange
            a = pi / 4;
            % act
            geo = G2.unitSquare();
            figure('Name', 'Rotate');
            geo.plot();
            hold('on');
            geo.rotate(a);
            geo.plot();
            hold('off');
            % assert
            testCase.assertTrue(true);
        end
        function translate(testCase)
            % arrange
            tx = 2;
            ty = 3;
            % act
            geo = G2.unitSquare();
            figure('Name', 'Translate');
            geo.plot();
            hold('on');
            geo.translate(tx, ty);
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
            geo = G2.rectangle(w, h);
            figure('Name', 'Rectangle');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function square(testCase)
            % arrange
            s = 2;
            % act
            geo = G2.square(s);
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
            geo = G2.ellipse(rx, ry);
            figure('Name', 'Ellipse');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function circle(testCase)
            % arrange
            r = 2;
            % act
            geo = G2.circle(r);
            figure('Name', 'Circle');
            geo.plot();
            % assert
            testCase.assertTrue(true);
        end
        function plot(testCase)
            % sin
            % - arrange
            x = linspace(-pi, pi, 100);
            y = sin(x);
            % - act
            geo = G2.line(x, y);
            figure('Name', 'Plot');
            geo.plot();
            
            % circle
            % - arrange
            a = linspace(0, 2 * pi, 100);
            x = cos(a);
            y = sin(a);
            % - act
            geo = G2.line(x, y);
            hold('on');
            geo.plot();
            hold('off');
            
            % assert
            testCase.assertTrue(true);
        end
%         function intersectionOfTwoSegments(testCase)
%             % arrange
%             segment1 = [
%                 0 -1
%                 0 1
%             ];
%             segment2 = [
%                 -1 0
%                 1 0
%             ];
%             expected.point = [0, 0];
%             expected.tf = true;
%             % act
%             [actual.point, actual.tf] = ...
%                 G2.intersectionOfTwoSegments(segment1, segment2);
%             % assert
%             testCase.assertEqual(actual, expected);
%         end
%         function pointOnSegment(testCase)
%             % arrange
%             point = [
%                 0, 1
%             ];
%             segment = [
%                 -1, 1
%                 1, 1
%             ];
%             expected = true;
%             % act
%             actual = G2.pointOnSegment(point, segment);
%             % assert
%             testCase.assertEqual(actual, expected);
%         end
    end
end
