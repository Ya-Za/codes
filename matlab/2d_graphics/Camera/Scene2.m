classdef Scene2 < handle
    %UNTITLED19 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        camera
        object
        limit
        h_figure
        h_real
        h_image
        camera_rotation_velocity
        camera_translation_velocity
    end
    
    methods
        function obj = Scene2(camera, object, limit)
            obj.camera = camera;
            obj.object = object;
            
            if nargin == 2
                obj.limit = 10;
            elseif nargin == 3
                obj.limit = limit;
            end
            
            obj.camera_rotation_velocity = 5;
            obj.camera_translation_velocity = 0.1;
            
            obj.init();
            obj.update();
        end
        
        function init(obj)
            % figure
            obj.h_figure = figure('Name', '2D Rendering', 'NumberTitle', 'off', 'Units', 'normalized', 'OuterPosition', [0, 0, 1, 1]);
            obj.h_figure.WindowKeyPressFcn = @obj.figure_WindowKeyPressFcn;
            
            % real
            obj.h_real = subplot(1, 2, 1); 
            axis([-obj.limit, obj.limit, -obj.limit, obj.limit]);
            xlabel('x'), ylabel('y'), zlabel('z');
            grid on; grid minor;
            
            % image
            obj.h_image = subplot(1, 2, 2);
        end
        
        function figure_WindowKeyPressFcn(obj, hObject, eventdata, handles)
            theta = 0;
            dy = 0;
            switch eventdata.Key
                case 'uparrow'
                    dy = obj.camera_translation_velocity;
                case 'downarrow'
                    dy = -obj.camera_translation_velocity;
                case 'rightarrow'
                    theta = -obj.camera_rotation_velocity;
                case 'leftarrow'
                    theta = obj.camera_rotation_velocity;
            end
            
            obj.camera.go(dy);
            obj.camera.rotate(theta);
            
            obj.update();   
        end
        
        function update(obj)
            % camera
            cla(obj.h_real);
            axes(obj.h_real);
            obj.camera.draw();
            
            % object
            obj.object.draw();
            
            % image
            
            if obj.object.is_polyline()
                image = obj.camera.get_image_of_polyline(obj.object);
            else
                image = obj.camera.get_image_of_points(obj.object);
            end
            
            cla(obj.h_image);
            axes(obj.h_image);
            imshow(image);
        end
    end
    
end

