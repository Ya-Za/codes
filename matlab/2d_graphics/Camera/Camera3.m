classdef Camera3 < handle
    %Camera3 simulate a 3-dimensional Camera
    
    properties
        plane                   % distance from near and far plane (near plane or focal length, far plane)
        size_                   % size of rendered image in pixel (height, width)
        aov                     % vertical angle of view
        
        theta                   % [theta_x, theta_y, theta_y]
        t                       % translation
        pts                     % pts(1) -> center of Camera3, pts(2:5) -> near plane, pts(6:9) -> far plane
    end
    
    methods
        function obj = Camera3()
            obj.plane = [1, 5];
            obj.size_ = [100, 100];
            obj.aov = 90;
            
            obj.theta = [0, 0, 0];
            obj.t = [0, 0, 0];
            obj.pts = [];
            
            obj.init();
        end
        
        function init(obj)
            
            
            f = obj.plane(1);
            F = obj.plane(2);
            
            aov_2 = obj.aov / 2;
            dy = tand(aov_2) * f;
            Dy = tand(aov_2) * F;
            
            height = obj.size_(1);
            width = obj.size_(2);
            ratio = width / height;
            
            dx = ratio * dy;
            Dx = ratio * Dy;
            
            
            center = [0, 0, 0];
            
            near_plane = [
                -dx,    -dy,    f
                dx,     -dy,    f
                dx,     dy,     f
                -dx,    dy,     f
            ];
        
            far_plane = [
                -Dx,    -Dy,    F
                Dx,     -Dy,    F
                Dx,     Dy,     F
                -Dx,    Dy,     F
            ];
                
            
            obj.pts = [
                center
                near_plane
                far_plane
            ];
        end
        
        function pts = local_to_global(obj, pts)
             pts = Camera3.do_transformation(pts, [obj.theta, obj.t]);
        end
        
        function draw(obj)
            points = obj.local_to_global(obj.pts);
            
            center = points(1, :);
            near_plane = points(2:5, :);
            far_plane = points(6:9, :);
            borders = [
                center, far_plane(1, :)
                center, far_plane(2, :)
                center, far_plane(3, :)
                center, far_plane(4, :)
            ];
        
            % draw global unit vectors
            Camera3.draw_global_unit_vectors();
            
            % draw local unit vectors
            obj.draw_local_unit_vectors();
        
            % near plane           
            Camera3.draw_closed_path(near_plane, 'blue');
            
            % far plane
            Camera3.draw_closed_path(far_plane, 'blue');
            
            % Camera3 center
            Camera3.draw_points(center, 'red');
            
            % border lines
            Camera3.draw_lines(borders(:, 1:3), borders(:, 4:6), 'blue');
        end
        
        function draw_local_unit_vectors(obj)
            center = [0, 0, 0];
            unit_vectors = [
                1, 0, 0
                0, 1, 0
                0, 0, 1
            ];
            colors = [
                1, 0, 0
                0, 1, 0
                0, 0, 1
            ];
            
            center = obj.local_to_global(center);
            unit_vectors = obj.local_to_global(unit_vectors);
            
            hold on;
            for i = 1:size(unit_vectors, 1)
                quiver3(center(1), center(2), center(3), unit_vectors(i, 1), unit_vectors(i, 2), unit_vectors(i, 3), ...
                    'Color', colors(i, :), ...
                    'LineWidth', 2 ...
                );
            end
            hold off;
        end
        
        function image = get_image_of_points(obj, object)
            width_px = obj.size_(2);
            height_px = obj.size_(1);
            
            image = zeros(height_px, width_px, 3);
            
            % M (extrinsic parameters)
            H = Camera3.get_H([obj.theta, obj.t]); % from Camera to world
            M = inv(H); % from world to Camera
            M = M(1:end - 1, :);
            
            % K (intrinsic parameters)
            ox = width_px / 2;
            oy = height_px / 2;
            f = height_px / (2 * tan(obj.aov / 2));
            K = [
                f, 0, ox
                0, f, oy
                0, 0, 1
            ];
            
            % world to Camera
            points = object.points';
            points = [points; ones(1, size(points, 2))];
            points = M * points;
            
%             % select points in frustum
%             indexes = inpolygon(points(1, :), points(2, :), obj.frustum(:, 1), obj.frustum(:, 2)); % indexes of points which are in frustum of Camera3
%             points = points(:, indexes);
%             colors = object.colors(indexes, :);
            
            % Camera to pixel
            points = K * points;
            points(1, :) = points(1, :) ./ points(3, :);
            points(2, :) = points(2, :) ./ points(3, :);
            
            % draw image
            for i = 1:size(points, 2)
                x = floor(points(1, i));
                y = floor(points(2, i));
                if x > 0 && x <= width_px && y > 0 && y <= height_px
                    image(y, x, :) = object.colors(i, :);
                end
            end
        end
        
        function image = get_image_of_polyline(obj, object)
            length_of_a_px = 1 / obj.dx;
            width_px = obj.width * obj.dx;
            image = zeros(1, width_px, 3);
            ratio = obj.F / obj.f;
            
            x = -obj.ox + (length_of_a_px / 2);            
            for i = 1:width_px
                p1 = [0, 0];
                p2 = ratio * [x, obj.f];
                
                p1 = obj.local_to_global(p1);
                p2 = obj.local_to_global(p2);
                
                Cam2.draw_lines(p1, p2, 'cyan');
                
                index = Cam2.linexpoly([p1, p2], object.points);
                if index ~= 0
                    image(1, i, :) = object.colors(index, :);
                end
                x = x + length_of_a_px;
            end
        end
        
        function go(obj, value)
            obj.t = obj.local_to_global([0, 0, value]);
        end
        
        function rotate(obj, value)
            obj.theta(2) = obj.theta(2) + value; 
        end
    end
    
    methods (Static)
        function draw_lines(p1, p2 ,colors)
            if size(p1, 1) ~= size(colors, 1)
                colors = repmat(colors, size(p1, 1), 1);
            end
            
            hold on;
            for i = 1:size(p1, 1)
                plot3([p1(i, 1), p2(i, 1)], [p1(i, 2), p2(i, 2)], [p1(i, 3), p2(i, 3)], 'Color', colors(i, :));
            end
            hold off;
        end
        
        function draw_polyline(poly, colors)
            Camera3.draw_lines(poly(:, 1:3), poly(:, 4:6), colors);
        end
        
        function draw_path(pts, color)
            for i = 1:(size(pts, 1) - 1)
                Camera3.draw_lines(pts(i, :), pts(i + 1, :), color);
            end
        end
        
        function draw_closed_path(pts, color)          
            Camera3.draw_path(pts, color);
            Camera3.draw_lines(pts(end, :), pts(1, :), color);
        end
        
        function draw_points(p, colors)
            hold on
            scatter3(p(:, 1), p(:, 2), p(:, 3), [], colors, 'filled');
            hold off
        end
        
        function draw_global_unit_vectors()
            center = [0, 0, 0];
            i_vector = [1, 0, 0];
            j_vector = [0, 1, 0];
            k_vector = [0, 0, 1];
            
            hold on;
            
            % i
            quiver3(center(1), center(2), center(3), i_vector(1), i_vector(2), i_vector(3), ...
                'Color', 'red', ...
                'LineWidth', 2 ...
            );
            % j
            quiver3(center(1), center(2), center(3), j_vector(1), j_vector(2), j_vector(3), ...
                'Color', 'green', ...
                'LineWidth', 2 ...
            );
            % k
            quiver3(center(1), center(2), center(3), k_vector(1), k_vector(2), k_vector(3), ...
                'Color', 'blue', ...
                'LineWidth', 2 ...
            );
        
            hold off;
        end
        
        function Rx = get_Rx(theta)
            c = cosd(theta);
            s = sind(theta);
            Rx = [
                1,  0,  0
                0,  c,  -s
                0,  s,  c
            ];
        end
        
        function Ry = get_Ry(theta)
            c = cosd(theta);
            s = sind(theta);
            Ry = [
                c,  0,  s
                0,  1,  0
                -s, 0,  c
            ];
        end
        
        function Rz = get_Rz(theta)
            c = cosd(theta);
            s = sind(theta);
            Rz = [
                c,  -s, 0
                s,  c,  0
                0,  0,  1
            ];
        end
        
        function Rxyz = get_Rxyz(theta)
            %Rxyz = Rz * Ry * Rz -> 3d rotation matrix
            %   theta = [theta_x, theta_y, theta_z]
            Rx = Camera3.get_Rx(theta(1));
            Ry = Camera3.get_Ry(theta(2));
            Rz = Camera3.get_Rz(theta(3));
            
            Rxyz = Rz * Ry * Rx;
        end
        
        function H = get_H(theta_t_array)
            H = eye(4);
            
            for i = 1:size(theta_t_array, 1)
                theta = theta_t_array(i, 1:3);
                R = Camera3.get_Rxyz(theta);
                
                t = theta_t_array(i, 4:6)';
                
                H = [R, t; [0 0 0 1]] * H;
            end  
        end
        
        function pts = do_transformation(pts, theta_t_array)
            pts = pts';
            pts = [pts; ones(1, size(pts, 2))];
            
            H = Camera3.get_H(theta_t_array);
            pts = H * pts;
            
            pts = pts(1:end - 1, :);
            pts = pts';
        end
        
        function theta_t_array = rotation_around_point(theta, p)
            z3 = zeros(1, 3);
            theta_t_array = [
                z3,      -p
                theta,   z3
                0,       p
            ];
        end
        
        function line = get_line_from_points(p1, p2)
             u = p2 - p1;
             u = u / norm(u);
             line = [p1, u];
        end
        
        function plane = get_plane_from_points(p1, p2, p3)
            p1p2 = p2 - p1;
            p2p3 = p3 - p2;
            n = cross(p1p2, p2p3);
            n = n / norm(n);
            d = dot(n, p1);
            
            plane = [n, -d];
        end
        
        function p = linexplane(line, plane)
            p = [];
            line = Camera3.get_line_from_points(line(1:3), line(4:6));
            plane = Camera3.get_plane_from_points(plane(1:3), plane(4:6), plane(7:9));
            
            p0 = line(1:3);
            u = line(4:6);
            n = plane(1:3);
            d = plane(4);
            
            denominator = dot(n, u);
            if denominator == 0
                return;
            end
            
            numerator = dot(n, p0) + d;
            lambda = - numerator / denominator;
            
            p = p0 + lambda * u;
            
            return;
        end
        
        function index = linexpoly(line, poly)
            indexes = [];
            distances = [];
            p0 = line(1:3);
            for i = 1:size(poly, 1)
                p = Camera3.linexplane(line, poly(i, :));
                if ~isempty(p)
                    indexes(end + 1) = i;
                    distances(end + 1) = norm(p - p0);
                end
            end
            
            if isempty(indexes)
                index = 0;
                return
            end
            
            if length(indexes) == 1
                index = indexes(1);
                return
            end
            
            [~, ii] = min(distances);
            index = indexes(ii);            
        end
    end
end

