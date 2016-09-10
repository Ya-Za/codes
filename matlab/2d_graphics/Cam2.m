classdef Cam2 < handle
    %UNTITLED17 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        theta
        t
        f
        width
        ox
        pts
    end
    
    methods
        function obj = Cam2(f, width, ox)
            if nargin < 1
                obj.f = 1;
                obj.width = 2;
                obj.ox = obj.width / 2;
            elseif nargin < 2
                obj.f = f;
                obj.width = 2;
                obj.ox = obj.width / 2;
            elseif nargin < 3
                obj.f = f;
                obj.width = width;
                obj.ox = obj.width / 2;
            else
                obj.f = f;
                obj.width = width;
                obj.ox = ox;
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
        end
        
        function pts = local_to_global(obj, pts)
             pts = Cam2.do_transformation(pts, [obj.theta, obj.t]);
        end
        
        function draw(obj)
            points = Cam2.do_transformation(obj.pts, [obj.theta, obj.t]);
            Cam2.draw_closed_path(points, 'blue');
            Cam2.draw_point(points(1, :), 'red');
        end
    end
    
    methods (Static)
        function pts = make_column_points(pts)
            if isrow(pts) || size(pts, 1) > size(pts, 2)
                pts = pts';
            end
        end
        
        function draw_line(p1, p2 ,color)
            hold on;
            plot([p1(1), p2(1)], [p1(2), p2(2)], 'Color', color);
            hold off;
        end
        
        function draw_path(pts, color)
            pts = Cam2.make_column_points(pts);
            
            for i = 1:(size(pts, 2) - 1)
                Cam2.draw_line(pts(:, i), pts(:, i + 1), color);
            end
        end
        
        function draw_closed_path(pts, color)
            pts = Cam2.make_column_points(pts);
            
            Cam2.draw_path(pts, color);
            Cam2.draw_line(pts(:, end), pts(:, 1), color);
        end
        
        function draw_point(p, color)
            hold on
            scatter(p(1), p(2), [], color, 'filled');
            hold off
        end
        
        function R = get_rotation_matrix(theta_deg)
            R = [cosd(theta_deg), -sind(theta_deg); sind(theta_deg), cosd(theta_deg)];
        end
        
%         function H = get_transformation_matrix(theta_deg, t)
%             R = Cam2.get_rotation_matrix(theta_deg);
%             if isrow(t)
%                 t = t';
%             end
%             H = [R, t; [0 0 1]];
%         end
        
        function H = get_transformation_matrix(theta_tx_ty_array)
            H = eye(3);
            
            for i = 1:size(theta_tx_ty_array, 1)
                theta_deg =     theta_tx_ty_array(i, 1);
                tx =            theta_tx_ty_array(i, 2);
                ty =            theta_tx_ty_array(i, 3);
                
                R = Cam2.get_rotation_matrix(theta_deg);
                t = [tx, ty]';
                H = [R, t; [0 0 1]] * H;
            end  
        end
        
        function pts = do_transformation(pts, theta_tx_ty_array)
            pts = Cam2.make_column_points(pts);
            pts = [pts; ones(1, size(pts, 2))];
            
            H = Cam2.get_transformation_matrix(theta_tx_ty_array);
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
    end
end

