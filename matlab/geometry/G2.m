classdef G2 < handle
    %2D geometry
    
    properties
        % - vertices: n-by-2 double matrix
        %   Vertices
        % - faces: m-by-2 int matrix
        %   Faces
        % - color: color
        %   Edge color
        
        vertices
        faces
        color
    end
    
    properties (Constant)
        eps = 1e-3;
        roundDigits = 3;
    end
    
    methods
        function obj = G2(vertices, faces, color)
            % Constructor
            
            % default values
            if ~exist('color', 'var')
                color = 'red';
            end
            
            obj.vertices = vertices;
            obj.faces = faces;
            obj.color = color;
        end
        function plot(obj)
            % Plot
            
            lineWidth = 2;
            
            patch(...
                'Vertices', obj.vertices, ...
                'Faces', obj.faces, ...
                'FaceColor', 'none', ...
                'EdgeColor', obj.color, ...
                'LineWidth', lineWidth ...
            );
        
            axis('equal');
        end
        function transform(obj, T)
            % 2D affine transformation
            
            n = size(obj.vertices, 1);
            V = [obj.vertices, ones(n, 1)];
            V = V * T;
            obj.vertices = V(:, 1:2);
        end
        function scale(obj, sx, sy)
            % 2D scale
            
            obj.transform(G2.scaleMatrix(sx, sy));
        end
        function rotate(obj, a)
            % 2D rotation
            
            obj.transform(G2.rotationMatrix(a));
        end
        function translate(obj, tx, ty)
            % 2D translation
            
            obj.transform(G2.translationMatrix(tx, ty));
        end
    end
    
    methods (Static)
        function geo = polyline(vertices)
            % Polyline
            
            n = size(vertices, 1);
            faces = [1:(n - 1); 2:n]';
            
            geo = G2(vertices, faces);
        end
        function geo = polygon(vertices)
            % Polygon
            
            n = size(vertices, 1);
            faces = [1:n; [2:n, 1]]';
            
            geo = G2(vertices, faces);
        end
        function geo = unitSquare()
            % Unit square
            
            vertices = [
                 0.5  0.5
                -0.5  0.5
                -0.5 -0.5
                 0.5 -0.5
            ];
            
            geo = G2.polygon(vertices);
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
            
            geo = G2.polygon(vertices);
        end
        function geo = unitCircle(n)
            % Unit circle
            
            % default values
            if ~exist('n', 'var')
                n = 100;
            end
            
            geo = G2.regularPolygon(n);
        end
        function T = scaleMatrix(sx, sy)
            % Scale matrix
            
            T = [
                sx 0  0
                0  sy 0
                0  0  1
            ]';
        end
        function T = rotationMatrix(a)
            % Rotation matrix
            
            c = cos(a);
            s = sin(a);
            T = [
                c -s  0
                s  c  0
                0  0  1
            ]';
        end
        function T = translationMatrix(tx, ty)
            % Translation matrix
            
            T = [
                1  0  tx
                0  1  ty
                0  0  1
            ]';
        end
        function geo = rectangle(w, h)
            % Rectangle
            
            geo = G2.unitSquare();
            geo.scale(w, h);
        end
        function geo = square(s)
            % Square
            
            geo = G2.rectangle(s, s);
        end
        function geo = ellipse(rx, ry)
            % Ellipse
            
            geo = G2.unitCircle();
            geo.scale(rx, ry);
        end
        function geo = circle(r)
            % Circle
            
            geo = G2.ellipse(r, r);
        end
        function geo = line(x, y)
            % line
            
            geo = G2.polyline([x(:), y(:)]);
        end
    end
    
    % CG Viz
    methods (Static)
        function plotPolygons(polygons)
            n = numel(polygons);
            color = (1:n)';
            for i = 1:n
                patch(...
                    'Vertices', polygons{i}, ...
                    'Faces', 1:size(polygons{i}, 1), ...
                    'EdgeColor', 'none', ...
                    'FaceColor', 'flat', ...
                    'FaceVertexCData', color(i) ...
                );
                hold('on');
            end
            hold('off');
        end
        function plotTriangles(points, triangles)
            patch(...
                'Vertices', points, ...
                'Faces', triangles, ...
                'FaceVertexCData', (1:size(triangles, 1))', ...
                'FaceColor', 'flat' ...
            );
        end
        function poly = getPolygon()
            axis([-5, 5, -5, 5]);
            poly = [];
            
            while true
                [x, y, btn] = ginput(1);
                
                % press `Enter` to exit
                if isempty(btn)
                    break;
                else
                    poly(end + 1, :) = [x, y];
                    plotPoly();
                end
            end
            
            % last edge
            poly(end + 1, :) = poly(1, :);
            plotPoly();
            
            poly(end, :) = [];
            poly = round(poly, G2.roundDigits);
            
            % Local function
            function plotPoly()
                plot(poly(:, 1), poly(:, 2));
                hold('on');
                scatter(poly(:, 1), poly(:, 2));
                hold('off');
                axis([-5, 5, -5, 5]);
            end
        end
        function plotPolygon(poly)
            poly(end + 1, :) = poly(1, :);
            
            x = poly(:, 1);
            y = poly(:, 2);
            
            plot(x, y);
            hold('on');
            
            scatter(x, y);
            hold('off');
        end
    end
    
    % Computational geometry
    methods (Static)
        function tf = eq(p1, p2)
            tf = norm(p1 - p2) < G2.eps;
        end
        function l = getLine(p1, p2, normal)
            % default values
            if ~exist('normal', 'var')
                normal = false;
            end
            
            u = p2 - p1;
            n = [-u(2), u(1)];
            l = [n, -dot(n, p1)];
            
            if normal
                nn = norm(n);
                if nn
                    l = l / norm(n);
                end
            end
        end
        function q = getNearestPointOnLine(p, p1, p2)
            u = p2 - p1;
            u = u / norm(u);
            
            v = p - p1;
            
            q = p1 + dot(u, v) * u;
        end
        function p = intersectionOfTwoLines(l1, l2)
            p = cross(l1, l2);
            
            if p(3) == 0
                p = [];
            else
                p = p / p(3);
                p = p(1:2);
            end
        end
        function [xMin, xMax, yMin, yMax] = boundingBox(points)
            x = points(:, 1);
            y = points(:, 2);
            
            xMin = min(x);
            xMax = max(x);
            yMin = min(y);
            yMax = max(y);
        end
        function tf = inBox(p, points)
            p = round(p, G2.roundDigits);
            points = round(points, G2.roundDigits);
            
            [xMin, xMax, yMin, yMax] = G2.boundingBox(points);

            tf = ...
                p(1) >= xMin && p(1) <= xMax && ...
                p(2) >= yMin && p(2) <= yMax;
        end
        function p = intersectionOfTwoSegments(p1, p2, q1, q2)
            l1 = G2.getLine(p1, p2);
            l2 = G2.getLine(q1, q2);
            
            p = G2.intersectionOfTwoLines(l1, l2);
            
            if isempty(p)
                return;
            end
            
            if G2.inBox(p, [p1; p2]) && G2.inBox(p, [q1; q2])
                return;
            end
                
            p = [];
        end
        function p = intersectionOfLineAndSegment(l1, p1, p2)
            l2 = G2.getLine(p1, p2);
            p = G2.intersectionOfTwoLines(l1, l2);
            
            if isempty(p)
                return;
            end
            
            if G2.inBox(p, [p1; p2])
                return;
            end
                
            p = [];
        end
%         function [point, tf, t] = intersectionOfTwoSegments(segment1, segment2)
%             % Intersection of two segmets
%             %
%             % Parameters
%             % ----------
%             % - segment1: 2-by-d double matrix
%             %   First segment
%             % - segment2: 2-by-d double matrix
%             %   Second segment
%             %
%             % Returns
%             % -------
%             % - point: 1-by-d double vector
%             %   Intersection point
%             % - tf: logical
%             %   Has just one valid intersection
%             
%             eps = 1e-6;
%             
%             % segment: P = P0 + t * u, 0 <= t <= 1
%             % - first segment
%             P0 = segment1(1, :);
%             u0 = segment1(2, :) - P0;
%             % - second segment
%             P1 = segment2(1, :);
%             u1 = segment2(2, :) - P1;
%             
%             A = [u0', -u1'];
%             if abs(det(A)) < eps
%                 point = [];
%                 tf = false;
%                 t = [];
%                 return;
%             end
%             
%             ts = A \ (P1 - P0)';
%             ts = round(ts, 3);
%             tf = ...
%                 ts(1) >= 0 && ts(1) <= 1 && ...
%                 ts(2) >= 0 && ts(2) <= 1;
%             
%             t = ts(1);
%             point = P0 + t * u0;
%         end
%         function tf = pointOnSegment(point, segment)
%             P0 = segment(1, :);
%             u0 = segment(2, :) - P0;
%             
%             t = (point - P0) ./ u0;
%             t = round(t, 3);
%             
%             tf = range(t) == 0 && t(1) >= 0 && t(1) <= 1;
%         end
        function tf = pointOnLine(q, p1, p2)
            l = G2.getLine(p1, p2);
            
            tf = abs(dot(l, [q, 1])) < G2.eps;
        end
        function tf = pointOnSegment(q, p1, p2)
            tf = ...
                G2.pointOnLine(q, p1, p2) && ...
                G2.inBox(q, [p1; p2]);
        end
        function s = signOfCross(u1, u2)
            z = cross([u1, 0], [u2, 0]);
            s = sign(z(3));
        end
        function s = signOfPolygon(points)
            e1 = points(2, :) - points(1, :);
            e2 = points(3, :) - points(2, :);
            
            s = G2.signOfCross(e1, e2);
        end
        function P = convexHull(S)
            % right most point
            [~, rightMostPointIndex] = max(S(:, 1));
            
            n = size(S, 1);
            P = S(rightMostPointIndex, :);
            while true
                endPoint = S(1, :);
                for j = 2:n
                    if pointOnRight(P(end, :), endPoint, S(j, :))
                        endPoint = S(j, :);
                    end
                end

                if all(P(1, :) == endPoint)
                    break;
                end
                
                P(end + 1, :) = endPoint;
            end
            
            % Local functions
            function tf = pointOnRight(p0, p1, q)
                tf = G2.signOfCross(p1 - p0, q - p0) < 0;
            end
        end
        function tf = isConvex(points)
            % Is polygon convex
            
            s = G2.signOfPolygon(points);
            
            n = size(points, 1);
            for i = 2:n
                u = points(i, :) - points(i - 1, :);
                for j = 1:n
                    v = points(j, :) - points(i - 1, :);
                    if G2.signOfCross(u, v) == -s
                        tf = false;
                        return;
                    end
                end
            end
            % last edge
            u = points(1, :) - points(n, :);
            for j = 1:n
                v = points(j, :) - points(n, :);
                if G2.signOfCross(u, v) == -s
                    tf = false;
                    return;
                end
            end
            
            tf = true;
        end
        function tf = pointOnPolygon(point, poly)
            n = size(poly, 1);
            
            for i = 1:n
                if G2.pointOnSegment(point, getPoint(i), getPoint(i + 1))
                    tf = true;
                    return;
                end
            end
            
            tf = false;
            
            % Local functions
            function p = getPoint(i)
                if i == n + 1
                    p = poly(1, :);
                else
                    p = poly(i, :);
                end
            end
        end
        function tf = evenOdd(poly, points)
            [xMin, xMax, yMin, yMax] = G2.boundingBox(poly);
            
            N = size(poly, 1);
            n = size(points, 1);
            tf = false(n, 1);
            
            for i = 1:n
                p = points(i, :);
                if ~inrange(p)
                    continue;
                end
                
                if G2.pointOnPolygon(p, poly)
                    tf(i) = true;
                    continue;
                end
                
                numberOfIntersections = getIntersections(p);
                
                if mod(numberOfIntersections, 2) == 1
                    tf(i) = true;
                end
            end
            
            % Local functions
            function tf = inrange(p)
                tf = ...
                    p(1) >= xMin && ...
                    p(1) <= xMax && ...
                    p(2) >= yMin && ...
                    p(2) <= yMax;
            end
            function numberOfIntersections = getIntersections(p)
                endPoint = [xMax + 1, p(2)];
                ray = endPoint - p;
                
                numberOfIntersections = 0;
                for j = 1:n
                    p1 = getVertex(j);
                    p2 = getVertex(j + 1);
                    q = G2.intersectionOfTwoSegments(p1, p2, p, endPoint);
                    if isempty(q)
                        continue;
                    end

                    if ~G2.eq(q, p1)
                        if ~G2.eq(q, p2)
                            numberOfIntersections = numberOfIntersections + 1;
                        else
                            s1 = G2.signOfCross(ray, p2 - p1);
                            
                            p3 = getVertex(j + 2);
                            s2 = G2.signOfCross(ray, p3 - p2);
                            if s2 == 0
                                p4 = getVertex(j + 3);
                                s2 = G2.signOfCross(ray, p4- p3);
                            end

                            if s1 * s2 > 0
                                numberOfIntersections = numberOfIntersections + 1;
                            end
                        end
                    end
                end

                
                % Local functions
                function point = getVertex(i)
                    if i > N
                        i = i - N;
                    end
                    point = poly(i, :);
                end
            end
        end
        function tf = nonZero(poly, points)
            [xMin, xMax, yMin, yMax] = G2.boundingBox(poly);
            
            N = size(poly, 1);
            n = size(points, 1);
            tf = false(n, 1);
            
            for i = 1:n
                p = points(i, :);
                if ~inrange(p)
                    continue;
                end
                
                if G2.pointOnPolygon(p, poly)
                    tf(i) = true;
                    continue;
                end
                
                numberOfIntersections = getIntersections(p);
                
                if numberOfIntersections ~= 0
                    tf(i) = true;
                end
            end
            
            % Local functions
            function tf = inrange(p)
                tf = ...
                    p(1) >= xMin && ...
                    p(1) <= xMax && ...
                    p(2) >= yMin && ...
                    p(2) <= yMax;
            end
            function numberOfIntersections = getIntersections(p)
                endPoint = [xMax + 1, p(2)];
                ray = endPoint - p;
                
                numberOfIntersections = 0;
                for j = 1:n
                    p1 = getVertex(j);
                    p2 = getVertex(j + 1);
                    q = G2.intersectionOfTwoSegments(p1, p2, p, endPoint);
                    if isempty(q)
                        continue;
                    end

                    if ~G2.eq(q, p1)
                        if ~G2.eq(q, p2)
                            numberOfIntersections = ...
                                numberOfIntersections + ...
                                G2.signOfCross(p2 - p1, p - p1);
                        else
                            s1 = G2.signOfCross(ray, p2 - p1);
                            
                            p3 = getVertex(j + 2);
                            s2 = G2.signOfCross(ray, p3 - p2);
                            if s2 == 0
                                p4 = getVertex(j + 3);
                                s2 = G2.signOfCross(ray, p4- p3);
                            end

                            if s1 * s2 > 0
                                numberOfIntersections = ...
                                    numberOfIntersections + ...
                                    G2.signOfCross(p2 - p1, p - p1);
                            end
                        end
                    end
                end

                
                % Local functions
                function point = getVertex(i)
                    if i > N
                        i = i - N;
                    end
                    point = poly(i, :);
                end
            end
        end
        function triangles = earClipping(points)
            % Returns
            % -------
            % - triangles: 3-by-2-by-n double matrix
            %   Matrix of triangles
            
            triangles = {};
            while size(points, 1) > 3
                index = findEar();
                addTriangle(index);
                clipEar(index);
            end
            addTriangle(1);
            
            % Local functions
            function p = getPoint(i)
                n = size(points, 1);
                if i > n
                    i = i - n;
                elseif i < 1
                    i = i + n;
                end
                
                p = points(i, :);
            end
            function s = signOfPoint(i)
                p1 = getPoint(i - 1);
                p2 = getPoint(i); 
                p3 = getPoint(i + 1);
                
                s = G2.signOfCross(...
                    p2 - p1, ...
                    p3 - p2 ...
                );
            end
            function tf = hasOverlap(i)
                % diameter
                p1 = getPoint(i - 1);
                p2 = getPoint(i + 1);
                % number of points
                n = size(points, 1);
                
                % start index
                j = i + 2;
                if j > n
                    j = j - n;
                end
                % stop index
                stop = i - 2;
                if stop < 1
                    stop = stop + n;
                end
                
                tf = false;
                while j ~= stop
                    p = G2.intersectionOfTwoSegments(...
                        p1, p2, ...
                        getPoint(j), getPoint(j + 1) ...
                    );
                    if ~isempty(p)
                        tf = true;
                        return;
                    end
                    
                    j = j + 1;
                    if j > n
                        j = j - n;
                    end
                end
            end
            function i = findEar()
                n = size(points, 1);
                
                for i = 1:n
                    s = signOfPoint(i);
                    if s == signOfPoint(i - 1) || s == signOfPoint(i + 1)
                        if ~hasOverlap(i)
                            return;
                        end
                    end
                end
            end
            function addTriangle(i)
                triangles{end + 1} = [
                    getPoint(i - 1)
                    getPoint(i)
                    getPoint(i + 1)
                ];
            end
            function clipEar(i)
                points(i, :) = [];
            end
        end
        function polygons = voronoi(points)
            box = getBox();
            
            polygons = {};
            
            numberOfPoints = size(points, 1);
            for indexOfPoint = 1:numberOfPoints
                polygons{end + 1} = getPolygon(indexOfPoint, box);
            end
            
            % Local functions
            function box = getBox()
                d = 1;
                
                [xMin, xMax, yMin, yMax] = G2.boundingBox(points);
                
                xMin = xMin - d;
                xMax = xMax + d;
                yMin = yMin - d;
                yMax = yMax + d;
                
                box = [
                    xMin yMin
                    xMin yMax
                    xMax yMax
                    xMax yMin
                ];
            end
            function poly = getPolygon(i, poly)
                for j = 1:numberOfPoints
                    if j == i
                        continue
                    end
                    
                    indexes = [];
                    intersectionPoints = [];
                    [p1, p2] = getPerpendicularBisector(i, j);
                    for k = 1:size(poly, 1)
                        intersectionPoint = hasLineSegmentIntersection(...
                            p1, p2, ...
                            getPoint(k), getPoint(k + 1) ...
                        );
                        if ~isempty(intersectionPoint)
                            indexes(end + 1, :) = k;
                            intersectionPoints(end + 1, :) = intersectionPoint;
                        end
                    end
                    cutPoly(i, indexes);
                end
                % Local function
                function [p1, p2] = getPerpendicularBisector(i, j)
                    P1 = points(i, :);
                    P2 = points(j, :);
                    
                    p1 = (P1 + P2) / 2;
                    
                    u = P2 - P1;
                    u_ = [-u(2), u(1)];
                    p2 = p1 + u_;
                end
                function p = hasLineSegmentIntersection(l1, p1, p2)
                    l2 = G2.getLine(p1, p2);
                    
                    p = G2.intersectionOfTwoLines(l1, l2);
                
                    if ~isempty(p)
                        if ~G2.inBox(p, [p1; p2]) || G2.eq(p, p2)
                            p = [];
                        end
                    end
                end
                function p = getPoint(i)
                    if i > size(poly, 1)
                        i = i - size(poly, 1);
                    end
                    p = poly(i, :);
                end
                function cutPoly(i, indexes)
                    if size(intersectionPoints, 1) < 2
                        return;
                    end
                    
                    p = points(i, :); % target points
                    a = intersectionPoints(1, :); % first intersection point
                    b = intersectionPoints(2, :); % second intersection point
                    q = poly(indexes(1) + 1, :); % point after `a`
                    
                    ab = b - a;
                    ap = p - a;
                    aq = q - a;
                    
                    s = G2.signOfCross(ab, ap) * G2.signOfCross(ab, aq);
                    
                    if s > 0
                        poly = [
                            a
                            poly((indexes(1) + 1):indexes(2), :)
                            b
                        ];
                    else
                        poly = [
                            poly(1:indexes(1), :)
                            a
                            b
                            poly(indexes(2) + 1:end, :)
                        ];
                    end
                end
            end
        end
        function triangles = delaunayFromVornoi(points)
            polygons = G2.voronoi(points);
            
            edges = [];
            adjacency = zeros(N, 'logical');
            
            numberOfPoints = size(points, 1);
            for indexOfPoint = 1:numberOfPoints
                point = points(indexOfPoint, :);
                polygon = polygons{indexOfPoint};
                
                P = getAllPoints(point, polygon);
                P = getCandidatePoints(point, P);
                indexes = getNeighbours(indexOfPoint, P);
                
                for indexOfNeighbour = indexes'
                    if validEdge(indexOfPoint, indexOfNeighbour)
                        addEdge(indexOfPoint, indexOfNeighbour);
                    end
                end
            end
            
            triangles = triangulateFromPlanarGraph(edges, adjacency);
            
            % Local functions
            function P = getAllPoints(point, polygon)
                n = size(polygon, 1);
                
                polygon = [polygon; polygon(1, :)];
                
                P = [];
                for i = 1:n
                    p1 = polygon(i, :);
                    p2 = polygon(i + 1, :);
                    
                    P(end + 1, :) = p1;
                    P(end + 1, :) = G2.getNearestPointOnLine(point, p1, p2);
                end
            end
            function Q = getCandidatePoints(p, P)
                n = size(P, 1);
                Q = zeros(size(P));
                
                for i = 1:n
                    u = P(i, :) - p;
                    Q(i, :) = p + 2 * u;
                end
            end
            function indexes = getNeighbours(indexOfPoint, P)
                indexes = [];
                
                n = size(P, 1);
                for i = 1:n
                    p = P(i, :);
                    for j = (indexOfPoint + 1):numberOfPoints
                        q = points(j, :);
                        if G2.eq(p, q)
                            indexes(end + 1) = j;
                            break;
                        end
                    end
                end
            end
            function tf = validEdge(i, j)
                tf = true;
                for k = 1:size(edges, 1)
                    if hasIntersect(i, j, edges(k, 1), edges(k, 2))
                        tf = false;
                        return;
                    end
                end
            end
            function p = getPoint(i)
                p = points(i, :);
            end
            function tf = hasIntersect(i, j, k, l)
                tf = false;
                
                p1 = getPoint(i);
                p2 = getPoint(j);
                
                q1 = getPoint(k);
                q2 = getPoint(l);
                
                % collinear
                if G2.eq(p2, q1) && G2.pointOnSegment(q1, p1, q2)
                    tf = true;
                    return;
                end
                if G2.eq(p2, q2) && G2.pointOnSegment(q2, p1, q1)
                    tf = true;
                    return;
                end
                
                p = G2.intersectionOfTwoSegments(p1, p2, q1, q2);
                
                if isempty(p)
                    return;
                end
                if G2.eq(p, q1) || G2.eq(p, q2)
                    return;
                end
                
                tf = true;
            end
            function addEdge(i, j)
                edges(end + 1, :) = [i, j];
                adjacency(i, j) = true;
                adjacency(j, i) = true;
            end
        end
        function [adjacency, edges] = planarGraph(points)
            N = size(points, 1);
            
            edges = [];
            adjacency = zeros(N, 'logical');
            
            for i = 1:N
                % remove
                % a -> b, a -> c -> b then remove a -> b
                removeRedundantEdges(getPoint(i));
                
                % add
                for j = 1:(i - 1)
                    if validEdge(i, j)
                        addEdge(i, j);
                    end
                end
            end
            
            % Local functions
            function removeRedundantEdges(q)
                for k = 1:size(edges, 1)
                    tf = G2.pointOnSegment(...
                        q, ...
                        getPoint(edges(k, 1)), ...
                        getPoint(edges(k, 2)) ...
                    );
                
                    if tf
                        removeEdge(k);
                    end
                end
            end
            function p = getPoint(i)
                p = points(i, :);
            end
            function removeEdge(edgeIndex)
                pointIndex1 = edges(edgeIndex, 1);
                pointIndex2 = edges(edgeIndex, 2);
                
                % remove edge from `vertices`
                adjacency(pointIndex1, pointIndex2) = false;
                adjacency(pointIndex2, pointIndex1) = false;
                
                % remove edge from `edges`
                edges(edgeIndex, :) = [];
            end
            function tf = validEdge(i, j)
                tf = true;
                for k = 1:size(edges, 1)
                    if hasIntersect(i, j, edges(k, 1), edges(k, 2))
                        tf = false;
                        return;
                    end
                end
            end
            function tf = hasIntersect(i, j, k, l)
                tf = false;
                
                p1 = getPoint(i);
                p2 = getPoint(j);
                
                q1 = getPoint(k);
                q2 = getPoint(l);
                
                % collinear
                if G2.eq(p2, q1) && G2.pointOnSegment(q1, p1, q2)
                    tf = true;
                    return;
                end
                if G2.eq(p2, q2) && G2.pointOnSegment(q2, p1, q1)
                    tf = true;
                    return;
                end
                
                p = G2.intersectionOfTwoSegments(p1, p2, q1, q2);
                
                if isempty(p)
                    return;
                end
                if G2.eq(p, q1) || G2.eq(p, q2)
                    return;
                end
                
                tf = true;
            end
            function addEdge(i, j)
                edges(end + 1, :) = [i, j];
                adjacency(i, j) = true;
                adjacency(j, i) = true;
            end
        end
        function triangles = triangulateFromPlanarGraphB(adjacency)
            % `B` at the end stands for `Brute-force`
            N = size(adjacency, 1);
            
            triangles = [];
            for i = 1:(N - 2)
                for j = (i + 1):(N - 1)
                    for k = (j + 1):N
                        if ...
                            adjacency(i, j) && ...
                            adjacency(i, k) && ...
                            adjacency(j, k)
                        
                            triangles(end + 1, :) = [i, j, k];
                        end
                    end
                end
            end
        end
        function triangles = triangulateFromPlanarGraph(adjacency, edges)
            triangles = [];
            
            for edgeIndex = 1:size(edges, 1)
                thirdPointIndexes = findThirdCommonPointIndexes(edgeIndex);
                addTriangles(edgeIndex, thirdPointIndexes);
                removeEdge(edgeIndex);
            end
            
            % Local functions
            function thirdIndexes = findThirdCommonPointIndexes(edgeIndex)
                thirdIndexes = find(and(...
                    adjacency(edges(edgeIndex, 1), :), ...
                    adjacency(edges(edgeIndex, 2), :) ...
                ));
            end
            function addTriangles(edgeIndex, thirdPointIndexes)
                a = edges(edgeIndex, 1);
                b = edges(edgeIndex, 2);
                
                for i = 1:numel(thirdPointIndexes)
                    c = thirdPointIndexes(i);
                    triangles(end + 1, :) = [a, b, c];
                end
            end
            function removeEdge(edgeIndex)
                a = edges(edgeIndex, 1);
                b = edges(edgeIndex, 2);
                
                adjacency(a, b) = false;
                adjacency(b, a) = false;
            end
        end
        function triangles = delaunay(points)
            [adjacency, edges] = G2.planarGraph(points);
            
            while true
                [quads, edgeIndexes] = findQuads();
                [quads, edgeIndexes] = filterQuads(quads, edgeIndexes);
                if isempty(quads)
                    break;
                end
                correctQuads(quads, edgeIndexes);
            end
            
            triangles = G2.triangulateFromPlanarGraph(adjacency, edges);
            
            % Local functions
            function [quads, edgeIndexes] = findQuads()
                quads = [];
                edgeIndexes = [];
                
                for i = 1:size(edges, 1)
                    a = edges(i, 1);
                    b = edges(i, 2);
                    
                    commonVertices = find(and(...
                        adjacency(a, :), ...
                        adjacency(b, :) ...
                    ));
                    
                    if numel(commonVertices) == 2
                        quads(end + 1, :) = [
                            a, ...
                            b, ...
                            commonVertices(1), ...
                            commonVertices(2) ...
                        ];
                    
                        edgeIndexes(end + 1) = i;
                    end
                end
            end
            function [filteredQuads, filteredEdgeIndexes] = filterQuads(quads, edgeIndexes)
                filteredQuads = [];
                filteredEdgeIndexes = [];
                
                for i = 1:size(quads, 1)
                    a = quads(i, 1);
                    b = quads(i, 2);
                    c = quads(i, 3);
                    d = quads(i, 4);
                    
                    if angle(a, c, b) + angle(a, d, b) > pi
                        filteredQuads(end + 1, :) = [a, b, c, d];
                        filteredEdgeIndexes(end + 1) = edgeIndexes(i);
                    end
                end
                
                % Local function
                function alpha = angle(a, b, c)
                    u1 = points(a, :) - points(b, :);
                    u1 = u1 / norm(u1);
                    
                    u2 = points(c, :) - points(b, :);
                    u2 = u2 / norm(u2);
                    
                    alpha = acos(dot(u1, u2));
                end
            end
            function correctQuads(quads, edgeIndexes)
                for i = 1:size(quads, 1)
                    a = quads(i, 1);
                    b = quads(i, 2);
                    c = quads(i, 3);
                    d = quads(i, 4);
                    
                    % remove edge
                    adjacency(a, b) = false;
                    adjacency(b, a) = false;
                    
                    edges(edgeIndexes(i), :) = [];
                    % add edge
                    adjacency(c, d) = true;
                    adjacency(d, c) = true;
                    
                    edges(end + 1, :) = [c, d];
                end
            end
        end
        function points = selfIntersectingToSimple(points)
            
            while update()
            end
            
            % Local functon 
            function point = getPoint(index)
                N = size(points, 1);
                if index > N
                    index = index - N;
                end

                point = points(index, :);
            end
            function tf = update()
                tf = false;
                
                N = size(points, 1);
                for i = 1:N
                    p1 = getPoint(i);
                    p2 = getPoint(i + 1);
                    
                    for j = 1:N
                        q1 = getPoint(j);
                        q2 = getPoint(j + 1);
                        
                        p = G2.intersectionOfTwoSegments(p1, p2, q1, q2);
                        
                        if isempty(p)
                            continue;
                        end
                        
                        if ~G2.eq(p, p1) && ~G2.eq(p, p2)
                            points = [
                                points(1:i, :)
                                p
                                points((i + 1):end, :)
                            ];
                            tf = true;
                            return;
                        end
                        
                        if ~G2.eq(p, q1) && ~G2.eq(p, q2)
                            points = [
                                points(1:j, :)
                                p
                                points((j + 1):end, :)
                            ];
                            tf = true;
                            return;
                        end
                    end
                end
            end
        end
        function points = correctPointsWithHoles(points)
            
            setOfPolygons = splitPoints();
            joinPolygons(setOfPolygons);
            
            % Local functions
            function setOfPolygons = splitPoints()
                setOfPolygons = {};
                indexOfPolygon = 1;
                
                setOfPolygons{indexOfPolygon} = [];
                
                for indexOfPoint = 1:size(points, 1)
                    p = points(indexOfPoint, :);
                    if isnan(p(1)) || isnan(p(2))
                        indexOfPolygon = indexOfPolygon + 1;
                        setOfPolygons{indexOfPolygon} = [];
                    else
                        setOfPolygons{indexOfPolygon}(end + 1, :) = p;
                    end
                end
            end
            function joinPolygons(setOfPolygons)
                points = [];
                
                for indexOfPolygon = 1:numel(setOfPolygons)
                    points = [
                        points
                        setOfPolygons{indexOfPolygon}(:, :)
                        setOfPolygons{indexOfPolygon}(1, :)
                        [NaN, NaN]
                    ];
                end
            end
        end
        function [triangles, points] = polygonTriangulate(points)
            % Triangulate given polygon
            
            points = G2.selfIntersectingToSimple(points);
            sp = getScanPointsAndUpdatePoints();
            si = changePointsWithIndecis(sp);
            op = getLocalOptimumPoints();
            trapzoids = getTrapzoids(si, op);
            triangles = triangulateTrapzoids(trapzoids);
            
            % Local functions
            function sp = getScanPointsAndUpdatePoints()
                
                % `y` coordinates
                % - get
                y = points(:, 2);
                % - unique
                y = unique(y);
                % - sort
                y = sort(y);
                
                n = size(y, 1);
                sp = cell(n, 1);
                
                for i = 1:n
                    sp{i} = [];
                    
                    % scan line
                    l = [0, 1, -y(i)];
                    
                    newPoints = {};
                    
                    for j = 1:size(points, 1)
                        p1 = getPoint(j);
                        p2 = getPoint(j + 1);
                        % if edge is a horizontal line
                        if (p1(2) == y(i)) && (p2(2) == y(i))
                            sp{i}(end + 1, :) = p1;
                            continue;
                        end
                        
                        p = G2.intersectionOfLineAndSegment(l, p1, p2);
                        
                        if isempty(p) || G2.eq(p, p2)
                            continue;
                        end
                        
                        sp{i}(end + 1, :) = p;
                        
                        if ~G2.eq(p, p1)
                            newPoints{end + 1} = struct(...
                                'index', j, ...
                                'point', p ...
                            );
                        end
                    end
                    
                    addNewPoints();
                end
                
                % Local functon 
                function point = getPoint(index)
                    N = size(points, 1);
                    if index > N
                        index = index - N;
                    end
                    
                    point = points(index, :);
                end
                function addNewPoints()
                    if isempty(newPoints)
                        return;
                    end
                    % first interval
                    addedPoints = [
                        points(1:newPoints{1}.index, :)
                        newPoints{1}.point
                    ];
                    % between intervals
                    n = numel(newPoints);
                    for k = 1:(n - 1)
                        addedPoints = [
                            addedPoints
                            points(...
                                newPoints{k}.index + 1:newPoints{k + 1}.index, ...
                                : ...
                            )
                            newPoints{k + 1}.point
                        ];
                    end
                    % last interval
                    addedPoints = [
                        addedPoints
                        points(newPoints{n}.index + 1:end, :)
                    ];
                
                    points = addedPoints;
                end
            end
            function si = changePointsWithIndecis(sp)
                n = numel(sp);
                si = cell(n, 1);
                for i = 1:n
                    m = size(sp{i}, 1);
                    si{i} = zeros(1, m);
                    for j = 1:m
                        si{i}(j) = findIndex(sp{i}(j, :));
                    end
                end
                
                % Local functions
                function index = findIndex(p)
                    for index = 1:size(points, 1)
                        if G2.eq(p, points(index, :))
                            return;
                        end
                    end
                end
            end
            function op = getLocalOptimumPoints()
                % `+1` -> local maximum
                % `-1` -> local minimum
               
                n = size(points, 1);
                op = zeros(1, n);
                
                for i = 1:n
                    s1 = getSign(i - 1);
                    s2 = getSign(i);

                    if s1 == 0 && s2 == 0
                        continue;
                    end

                    if s1 <= 0 && s2 >= 0
                        op(i) = -1;
                    elseif s1 >= 0 && s2 <= 0
                        op(i) = 1;
                    end
                end
                
                % Local functions
                function p = getPoint(index)
                    if index < 1
                        index = index + n;
                    elseif index > n
                        index = index - n;
                    end
                    
                    p = points(index, :);
                end
                function s = getSign(index)
                    p1 = getPoint(index);
                    p2 = getPoint(index + 1);
                    
                    s = sign(p2(2) - p1(2));
                end
            end
            function trapzoids = getTrapzoids(si, op)
                trapzoids = {};
                
                for i = 1:(numel(si) - 1)
                    pi1 = si{i};
                    pi1 = removeLocalMaximum(pi1);
                    pi1 = sortByXCoordinate(pi1);
                    
                    pi2 = si{i + 1};
                    pi2 = removeLocalMinimum(pi2);
                    pi2 = sortByXCoordinate(pi2);
                    
                    while ~isempty(pi1) && ~isempty(pi2)
                        trapzoids{end + 1} = getTrapzoid();
                    end
                end
                
                % Local functions
                function fpi = removeLocalMaximum(pi)
                    % filtered point indexes
                    fpi = [];
                    for k = 1:numel(pi)
                        index = pi(k);
                        if op(index) ~= 1
                            fpi(end + 1) = index;
                        end
                    end
                end
                function fpi = removeLocalMinimum(pi)
                    % filtered point indexes
                    fpi = [];
                    for k = 1:numel(pi)
                        index = pi(k);
                        if op(index) ~= -1
                            fpi(end + 1) = index;
                        end
                    end
                end
                function spi = sortByXCoordinate(pi)
                    % sorted point indexes
                    
                    x = points(pi, 1);
                    [~, xi] = sort(x);
                    spi = pi(xi);
                end
                function trapzoid = getTrapzoid()
                    trapzoid = [];
                    n1 = numel(pi1);
                    n2 = numel(pi2);
                    % <= 4
                    if n1 + n2 <= 4
                        if n2 == 1
                            trapzoid = [pi2(1), pi1];
                        else
                            trapzoid = [pi2(1), pi1, pi2(2)];
                        end
                        pi2 = [];
                        pi1 = [];
                        return;    
                    end
                    % triangle
                    % - ^
                    if op(pi2(1)) == 1
                        trapzoid = [pi2(1), pi1(1), pi1(2)];
                        
                        pi2 = pi2(2:end);
                        
                        if op(pi1(2)) == -1
                            pi1 = pi1(2:end);
                        else
                            pi1 = pi1(3:end);
                        end
                        
                        return;
                    end
                    % - v
                    if op(pi1(1)) == -1
                        trapzoid = [pi2(1), pi1(1), pi2(2)];
                        
                        pi1 = pi1(2:end);
                        
                        if op(pi2(2)) == 1
                            pi2 = pi2(2:end);
                        else
                            pi2 = pi2(3:end);
                        end
                        
                        return;
                    end
                    
                    % trapzoid
                    trapzoid = [pi2(1), pi1(1), pi1(2), pi2(2)];
                    if op(pi2(2)) == 1
                        pi2 = pi2(2:end);
                        pi1 = pi1(3:end);
                    elseif op(pi1(2)) == -1
                        pi1 = pi1(2:end);
                        pi2 = pi2(3:end);
                    else
                        pi1 = pi1(3:end);
                        pi2 = pi2(3:end);
                    end
                        
                end
            end
            function triangles = triangulateTrapzoids(trapzoids)
                
                triangles = [];
                
                for i = 1:numel(trapzoids)
                    tz = trapzoids{i};
                    if numel(tz) == 3
                        triangles(end + 1, :) = tz;
                    else
                        triangles(end + 1, :) = [tz(1), tz(2), tz(3)];
                        triangles(end + 1, :) = [tz(1), tz(3), tz(4)];
                    end
                end
            end
        end
    end
end
