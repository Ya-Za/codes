classdef Camera2 < handle
    %Camera2 simulate a 2-dimensional Camera
    
    properties
        plane                   % distance from near and far plane (near plane or focal length, far plane)
        width                   % width of rendered image in pixel
        aov                     % horizontal angle of view
        
        theta                   % theta of rotation matrix
        t                       % translation
        pts                     % pts(1) -> center of Camera3, pts(2:3) -> near plane, pts(4:5) -> far plane
        color                   % color.center, color.near_plaen, color.far_plane, color.border_lines
        frustum
    end
    
    methods
        function obj = Camera2()
            obj.plane = [1, 5];
            obj.width = 100;
            obj.aov = 90;
            
            obj.theta = 0;
            obj.t = [0, 0];
            obj.pts = [];
                        
            obj.color.center = [0.9, 0.2, 0.2];
            obj.color.near_plane = [0.2, 0.2, 0.9];
            obj.color.far_plane = [0.2, 0.2, 0.9];
            obj.color.border_lines = [0.2, 0.2, 0.9];
            
            obj.init();
        end
        
        function init(obj)
            f = obj.plane(1);
            F = obj.plane(2);
            
            aov_2 = obj.aov / 2;
            dx = tand(aov_2) * f;
            Dx = tand(aov_2) * F;            
            
            center = [0, 0];
            
            near_plane = [
                -dx,    f
                dx,     f
            ];
        
            far_plane = [
                -Dx,    F
                Dx,     F
            ];    
            
            obj.pts = [
                center
                near_plane
                far_plane
            ];
        
            obj.frustum = [
                obj.pts(2, :), obj.pts(3, :)
                obj.pts(4, :), obj.pts(5, :)
                obj.pts(2, :), obj.pts(4, :)
                obj.pts(3, :), obj.pts(5, :)
            ];
        end
        
        function pts = local_to_global(obj, pts)
             pts = Camera2.do_transformation(pts, [obj.theta, obj.t]);
        end
        
        function draw_local_unit_vectors(obj)
            center = [0, 0];
            unit_vectors = [
                1, 0
                0, 1
            ];
            colors = [
                1, 0, 0
                0, 1, 0
                0, 0, 1
            ];
            
            center = obj.local_to_global(center);
            unit_vectors = obj.local_to_global(unit_vectors);
            
            hold on;
            
            Camera2.draw_arrows( ...
                repmat(center, size(unit_vectors, 1), 1), ...
                unit_vectors, ...
                colors ...
            );
            
            hold off;
        end
        
%         function image = get_image_of_points(obj, object)            
%             image = zeros(1, obj.width, 3);
%             
%             % M (extrinsic parameters)
%             H = Camera2.get_H([obj.theta, obj.t]); % from Camera to world
%             M = inv(H); % from world to Camera
%             M = M(1:end - 1, :);
%             
%             % K (intrinsic parameters)
%             ox = obj.width / 2;
%             f = obj.width / (2 * tan(obj.aov / 2));
%             K = [
%                 f, ox
%                 0, 1
%             ];
%             
%             % world to Camera
%             points = object.points';
%             points = [points; ones(1, size(points, 2))];
%             points = M * points;
%             
%             % select points in frustum
%             indexes = obj.select_points_in_frustum(points');
%             points = points(:, indexes);
%             colors = object.colors(indexes, :);
%             
%             p2 = points';
%             
%             % Camera to pixel
%             points = K * points;
%             points(1, :) = points(1, :) ./ points(end, :);
%             
%             % draw image and rays
%             if ~isempty(points)
%                 u = (obj.pts(3, :) - obj.pts(2, :)) / obj.width;
%                 p1 = [];
%                 
%                 for i = 1:size(points, 2)
%                     x = floor(points(1, i)) + 1;
%                     if x >= 1  && x <= obj.width
%                         image(1, x, :) = colors(i, :);
%                         p1(end + 1, :) = obj.pts(2, :) + ((x - 0.5) * u);
%                     end
%                 end
%                 
%                 Camera2.draw_lines(obj.local_to_global(p1), obj.local_to_global(p2), 'cyan');
%             end
%             
%             % draw image
%             
%         end

        function image = get_image_of_points(obj, object)            
            image = zeros(1, obj.width, 3);
            
            % M (extrinsic parameters)
            H = Camera2.get_H([obj.theta, obj.t]); % from Camera to world
            M = inv(H); % from world to Camera
            M = M(1:end - 1, :);
            
            % K (intrinsic parameters)
            ox = obj.width / 2;
            f = obj.width / (2 * tan(obj.aov / 2));
            K = [
                f, ox
                0, 1
            ];
            
            % world to Camera
            points = object.points';
            points = [points; ones(1, size(points, 2))];
            points = M * points;
            
            % select points in frustum
            indexes = obj.select_points_in_frustum(points');
            points = points(:, indexes);
            colors = object.colors(indexes, :);
            
            p2 = points';
            
            % Camera to pixel
            points = K * points;
            points(1, :) = points(1, :) ./ points(end, :);
            
            color_data = cell(obj.width, 1);
            if ~isempty(points)                
                for i = 1:size(points, 2)
                    x = floor(points(1, i)) + 1;
                    if x >= 1  && x <= obj.width
                        new_data.length = norm(p2(i, :));
                        new_data.direction = round(p2(i, :) / new_data.length, 4);
                        new_data.color = colors(i, :);
                        
                        in_same_direction = false;
                        for j = 1:length(color_data{x})
                            if all(color_data{x}{j}.direction == new_data.direction)
                                in_same_direction = true;
                                if new_data.length < color_data{x}{j}.length
                                    color_data{x}{j} = new_data;
                                end
                                break;
                            end
                        end
                        if in_same_direction == false
                            color_data{x}{end + 1} = new_data;
                        end
                    end
                end
            end
            
            % draw image and rays
            if ~isempty(points)
                u = (obj.pts(3, :) - obj.pts(2, :)) / obj.width;
                p1 = [];
                
                for i = 1:size(points, 2)
                    x = floor(points(1, i)) + 1;
                    if x >= 1  && x <= obj.width
                        sum_of_lengthes = 0;
                        for j = 1:length(color_data{x})
                            sum_of_lengthes = sum_of_lengthes + color_data{x}{j}.length;
                        end
                        point_color = [0, 0, 0];
                        for j = 1:length(color_data{x})
                            point_color = point_color + color_data{x}{j}.color * (color_data{x}{j}.length / sum_of_lengthes);
                        end
                        image(1, x, :) = point_color;
                        p1(end + 1, :) = obj.pts(2, :) + ((x - 0.5) * u);
                    end
                end
                
                Camera2.draw_lines(obj.local_to_global(p1), obj.local_to_global(p2), 'cyan');
            end
            
            % draw image
            
        end
        
        function image = get_image_of_polyline(obj, object)
            image = zeros(1, obj.width, 3);                        
            
            p1 = obj.pts(2, :);
            u1 = (obj.pts(3, :) - obj.pts(2, :)) / obj.width;
            p1 = p1 + (u1 / 2);
            
            p2 = obj.pts(4, :);
            u2 = (obj.pts(5, :) - obj.pts(4, :)) / obj.width;
            p2 = p2 + (u2 / 2);
            for i = 1:obj.width                
                q1 = obj.local_to_global(p1);
                q2 = obj.local_to_global(p2);
                
                Camera2.draw_lines(q1, q2, 'cyan');
                
                index = Camera2.linexpoly([q1, q2], object.points);
                if index ~= 0
                    image(1, i, :) = object.colors(index, :);
                end
                
                p1 = p1 + u1;
                p2 = p2 + u2;
            end
        end
        
        function go(obj, value)
            obj.t = obj.local_to_global([0, value]);
        end
        
        function rotate(obj, value)
            obj.theta = obj.theta + value; 
        end
        
        function res = is_point_in_frustum(obj, p)
            % using ray casting methods
            % p = obj.local_to_global(p);
            
            center = obj.pts(1, :);
            s = [p, center];
        
            number_of_collisions = 0;
            for i = 1:size(obj.frustum, 1)
                if ~isempty(Camera2.segmentxsegment(s, obj.frustum(i, :)))
                    number_of_collisions = number_of_collisions + 1;
                end
            end
            
            if mod(number_of_collisions, 2) == 1
                res = true;
            else
                res = false;
            end
        end
        
        function indexes = select_points_in_frustum(obj, points)
            indexes = [];
            for i = 1:size(points, 1)
                if obj.is_point_in_frustum(points(i, :))
                    indexes(end + 1) = i;
                end
            end
        end
        
        function draw(obj)
            points = obj.local_to_global(obj.pts);
            
            center = points(1, :);
            near_plane = points(2:3, :);
            far_plane = points(4:5, :);
            borders = [
                center, far_plane(1, :)
                center, far_plane(2, :)
            ];
        
            % draw global unit vectors
            Camera2.draw_global_unit_vectors();
            
            % draw local unit vectors
            obj.draw_local_unit_vectors();
        
            % near plane           
            Camera2.draw_closed_path(near_plane, obj.color.near_plane);
            
            % far plane
            Camera2.draw_closed_path(far_plane, obj.color.far_plane);
            
            % border lines
            Camera2.draw_lines(borders(:, 1:2), borders(:, 3:4), obj.color.border_lines);
            
            % center
            Camera2.draw_points(center, obj.color.center);
            
            % title
            str = sprintf('\\bf{(\\theta, x, y): (%.2f, %.2f, %.2f)}', obj.theta, obj.t(1), obj.t(2));
            title(str, 'Interpreter', 'tex');
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
        
        function draw_arrows(p1, p2, colors)
            if size(p1, 1) ~= size(colors, 1)
                colors = repmat(colors, size(p1, 1), 1);
            end
            
            hold on;
            for i = 1:size(p1, 1)
                quiver(p1(i, 1), p1(i, 2), p2(i, 1) - p1(i, 1), p2(i, 2) - p1(i, 2), ...
                    'Color', colors(i, :), ...
                    'LineWidth', 2 ...
                );
            end
            hold off;
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
        
        function R = get_R(theta_deg)
            R = [cosd(theta_deg), -sind(theta_deg); sind(theta_deg), cosd(theta_deg)];
        end
        
        function H = get_H(theta_tx_ty_array)
            H = eye(3);
            
            for i = 1:size(theta_tx_ty_array, 1)
                theta_deg =     theta_tx_ty_array(i, 1);
                tx =            theta_tx_ty_array(i, 2);
                ty =            theta_tx_ty_array(i, 3);
                
                R = Camera2.get_R(theta_deg);
                t = [tx, ty]';
                H = [R, t; [0 0 1]] * H;
            end  
        end
        
        function pts = do_transformation(pts, theta_tx_ty_array)
            pts = pts';
            pts = [pts; ones(1, size(pts, 2))];
            
            H = Camera2.get_H(theta_tx_ty_array);
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
        
        function res = is_point_in_segment_box(p, segment)
            x = round(p(1), 4);
            y = round(p(2), 4);
            
            x1 = round(min(segment(1), segment(3)), 4);
            x2 = round(max(segment(1), segment(3)), 4);
            y1 = round(min(segment(2), segment(4)), 4);
            y2 = round(max(segment(2), segment(4)), 4);
            
            if x >= x1 && x <= x2 && y >= y1 && y <= y2
                res = true;
            else
                res = false;
            end
        end
        
        function line = get_line_from_points(p1, p2)
             u = p2 - p1;
             u = u / norm(u);
             line = [p1, u];
        end
        
        function p = linexline(l1, l2)
            p = [];
            A = [l1(3:4)', -l2(3:4)'];
            
            if det(A) == 0
                return;
            end
            
            lambda = A \ (l2(1:2)' - l1(1:2)');
            
            p = l1(1:2) + lambda(1) * l1(3:4);
        end
        
        function p = segmentxsegment(s1, s2)
            l1 = Camera2.get_line_from_points(s1(1:2), s1(3:4));
            l2 = Camera2.get_line_from_points(s2(1:2), s2(3:4));
            
            p = Camera2.linexline(l1, l2);
            if isempty(p)
                return;
            end
            
            if Camera2.is_point_in_segment_box(p, s1) && Camera2.is_point_in_segment_box(p, s2)
                return
            end
            
            p = [];
        end
        
        function index = linexpoly(line, poly)
            indexes = [];
            distances = [];
            for i = 1:size(poly, 1)
                p = Camera2.segmentxsegment(line, poly(i, :));
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

