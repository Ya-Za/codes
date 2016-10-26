classdef Camera2 < handle
    %Camera2 simulate a 2-dimensional camera
    
    properties
        theta
        t
        f
        width
        ox
        dx
        maximum_distance
        pts
        frustum
    end
    
    methods
        function obj = Camera2(f, width, ox, dx, maximum_distance)
            if nargin < 1
                obj.f = 1;
                obj.width = 2;
                obj.ox = obj.width / 2;
                obj.dx = 1;
                obj.maximum_distance = 5;
            elseif nargin < 2
                obj.f = f;
                obj.width = 2;
                obj.ox = obj.width / 2;
                obj.dx = 1;
                obj.maximum_distance = 5;
            elseif nargin < 3
                obj.f = f;
                obj.width = width;
                obj.ox = obj.width / 2;
                obj.dx = 1;
                obj.maximum_distance = 5;
            elseif nargin < 4
                obj.f = f;
                obj.width = width;
                obj.ox = ox;
                obj.dx = 1;
                obj.maximum_distance = 5;
            elseif nargin < 5
                obj.f = f;
                obj.width = width;
                obj.ox = ox;
                obj.dx = dx;
                obj.maximum_distance = 5;
            else
                obj.f = f;
                obj.width = width;
                obj.ox = ox;
                obj.dx = dx;
                obj.maximum_distance = maximum_distance;
            end
            
            obj.init();
        end
        
        function init(obj)
            obj.theta = 0;
            obj.t = [0, 0];
            
            obj.pts = [
                0,                      0
                -obj.ox,                obj.f
                -obj.ox + obj.width,    obj.f
            ];
            
            ratio = obj.maximum_distance / obj.f;
            obj.frustum = [
                obj.pts(2, :)
                -obj.ox * ratio                 obj.maximum_distance
                (-obj.ox + obj.width) * ratio   obj.maximum_distance
                obj.pts(3, :)
            ];
        end
        
        function pts = local_to_global(obj, pts)
             pts = Camera2.do_transformation(pts, [obj.theta, obj.t]);
        end
        
        function draw(obj)
            % camera
            points = Camera2.do_transformation(obj.pts, [obj.theta, obj.t]);
            Camera2.draw_closed_path(points, 'blue');
            
            % draw global unit vectors
            Camera2.draw_global_unit_vectors();
            
            % camera center
            Camera2.draw_points(points(1, :), 'red');
            
            % frustum
            points = Camera2.do_transformation(obj.frustum, [obj.theta, obj.t]);
            Camera2.draw_path(points, 'green');
        end
        
        function image = get_image_of_points(obj, object)
            width_px = obj.width * obj.dx;
            image = zeros(1, width_px, 3);
            
            % M (extrinsic parameters)
            H = Camera2.get_transformation_matrix([obj.theta, obj.t]); % from camera to world
            M = inv(H); % from world to camera
            M = M(1:2, :);
            
            % K (intrinsic parameters)
            K = [obj.f * obj.dx, obj.ox * obj.dx; 0 1];
            
            % world to camera
            points = object.points';
            points = [points; ones(1, size(points, 2))];
            points = M * points;
            
            % select points in frustum
            indexes = inpolygon(points(1, :), points(2, :), obj.frustum(:, 1), obj.frustum(:, 2)); % indexes of points which are in frustum of camera
            points = points(:, indexes);
            colors = object.colors(indexes, :);
            
            % camera to pixel
            points = K * points;
            points = points(1, :) ./ points(2, :);
            
            % draw image
            for i = 1:length(points)
                x = floor(points(i));
                if x > 0 && x <= width_px
                    image(1, x, :) = colors(i, :);
                end
            end
        end
        
        function image = get_image_of_polyline(obj, object)
            length_of_a_px = 1 / obj.dx;
            width_px = obj.width * obj.dx;
            image = zeros(1, width_px, 3);
            ratio = obj.maximum_distance / obj.f;
            
            x = -obj.ox + (length_of_a_px / 2);            
            for i = 1:width_px
                p1 = [0, 0];
                p2 = ratio * [x, obj.f];
                
                p1 = obj.local_to_global(p1);
                p2 = obj.local_to_global(p2);
                
                Camera2.draw_lines(p1, p2, 'cyan');
                
                index = Camera2.linexpoly([p1, p2], object.points);
                if index ~= 0
                    image(1, i, :) = object.colors(index, :);
                end
                x = x + length_of_a_px;
            end
        end
        
        function go(obj, value)
            obj.t = obj.local_to_global([0, value]);
        end
        
        function rotate(obj, value)
            obj.theta = obj.theta + value; 
        end
    end
    
    methods (Static)
        function draw_lines(p1, p2 ,colors)
            if size(p1, 1) ~= size(colors, 1)
                colors = repmat(colors, size(p1, 1), 1);
            end
            
            hold on;
            for i = 1:size(p1, 1)
                plot([p1(i, 1), p2(i, 1)], [p1(i, 2), p2(i, 2)], 'Color', colors(i, :));
            end
            hold off;
        end
        
        function draw_polyline(poly, colors)
            Camera2.draw_lines(poly(:, 1:2), poly(:, 3:4), colors);
        end
        
        function draw_path(pts, color)
            for i = 1:(size(pts, 1) - 1)
                Camera2.draw_lines(pts(i, :), pts(i + 1, :), color);
            end
        end
        
        function draw_closed_path(pts, color)          
            Camera2.draw_path(pts, color);
            Camera2.draw_lines(pts(end, :), pts(1, :), color);
        end
        
        function draw_points(p, colors)
            hold on
            scatter(p(:, 1), p(:, 2), [], colors, 'filled');
            hold off
        end
        
        function draw_global_unit_vectors()
            center = [0, 0];
            i_vector = [1, 0];
            j_vector = [0, 1];
            
            hold on;
            
            % i
            quiver(center(1), center(2), i_vector(1), i_vector(2), ...
                'Color', 'red', ...
                'LineWidth', 2 ...
            );
            % j
            quiver(center(1), center(2), j_vector(1), j_vector(2), ...
                'Color', 'green', ...
                'LineWidth', 2 ...
            );            
        
            hold off;
        end
        
        function R = get_rotation_matrix(theta_deg)
            R = [cosd(theta_deg), -sind(theta_deg); sind(theta_deg), cosd(theta_deg)];
        end
        
        function H = get_transformation_matrix(theta_tx_ty_array)
            H = eye(3);
            
            for i = 1:size(theta_tx_ty_array, 1)
                theta_deg =     theta_tx_ty_array(i, 1);
                tx =            theta_tx_ty_array(i, 2);
                ty =            theta_tx_ty_array(i, 3);
                
                R = Camera2.get_rotation_matrix(theta_deg);
                t = [tx, ty]';
                H = [R, t; [0 0 1]] * H;
            end  
        end
        
        function pts = do_transformation(pts, theta_tx_ty_array)
            pts = pts';
            pts = [pts; ones(1, size(pts, 2))];
            
            H = Camera2.get_transformation_matrix(theta_tx_ty_array);
            pts = H * pts;
            
            pts = pts(1:2, :);
            pts = pts';
        end
        
        function theta_tx_ty_array = rotation_around_point(theta, p)
            theta_tx_ty_array = [
                0,       -p(1),     -p(2)
                theta,   0,         0
                0,       p(1),      p(2)
            ];
        end
        
        function p = linexline(line1, line2)
            p = [];
            [x, y] = polyxpoly(...
                [line1(1), line1(3)], [line1(2), line1(4)],...
                [line2(1), line2(3)], [line2(2), line2(4)]);
            if isempty(x)
                return
            end
            
            p = [x(1), y(1)];
            return;
        end
        
        function index = linexpoly(line, poly)
            indexes = [];
            distances = [];
            for i = 1:size(poly, 1)
                p = Camera2.linexline(line, poly(i, :));
                if ~isempty(p)
                    indexes(end + 1) = i;
                    distances(end + 1) = norm(p);
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

