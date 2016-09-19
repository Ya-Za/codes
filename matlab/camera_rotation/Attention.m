classdef Attention < handle
    %Attention visualizes attention of a neuron
    
    properties
        limits
        number_of_points
        sigma1
        mu1
        number_of_iterations
        delay
        dir_path
        save_frames
        h_fig
        h_ax
        h_plot
        frame_index
        x
        y
        z1
    end
    
    methods
        function obj = Attention()
            obj.limits = [-5, 5];
            obj.number_of_points = 100;
            obj.sigma1 = [
                1, 0
                0, 1
            ];
            obj.mu1 = [0, 0];

            obj.number_of_iterations = 20;

            obj.delay = 0.3;

            obj.dir_path = './frames';

            obj.save_frames = false;
            
            obj.h_fig = figure(...
                'Name', 'Attention', ...
                'Units', 'normalize', ...
                'OuterPosition', [0, 0, 1, 1], ...
                'NumberTitle', 'off' ...
            );
        
            obj.h_ax = axes(obj.h_fig);
            
            obj.frame_index = 1;
        end
        
        function init(obj)
            if obj.save_frames == true
                if exist(obj.dir_path, 'dir')
                    rmdir(obj.dir_path, 's')
                end
                mkdir(obj.dir_path);
            end
        end
        
        function save_frame(obj)
            if obj.save_frames == true
                frame = getframe(obj.h_ax);
                frame = frame.cdata;
                imwrite(frame, fullfile(obj.dir_path, sprintf('frame_%04d.png', obj.frame_index)));
                obj.frame_index = obj.frame_index + 1;
            end
        end
        
        function rotate_camera(obj)
            obj.x = linspace(obj.limits(1), obj.limits(2), obj.number_of_points)';
            obj.y = obj.x;
            [obj.x, obj.y] = meshgrid(obj.x, obj.y);

            obj.z1 = mvnpdf([obj.x(:), obj.y(:)], obj.mu1, obj.sigma1);
            obj.z1 = reshape(obj.z1, size(obj.x));
            obj.h_plot = surf(obj.h_ax, obj.z1);
            set(obj.h_ax, 'Visible', 'off');
            shading interp;

            [a, e] = view(obj.h_ax);
            da = (0 - a) / obj.number_of_iterations;
            de = (90 - e) / obj.number_of_iterations;

            for i = 1:obj.number_of_iterations
                [a, e] = view(obj.h_ax);
                view(obj.h_ax, a + da, e + de);

                obj.save_frame();

                pause(obj.delay);
            end

        end
        
        function transparent_plot(obj)
            hold on;
            contour3(obj.h_ax, obj.z1, 'LineWidth', 2);
            set(obj.h_ax, 'Visible', 'off');
            hold off;
            
            delta_alpha = 1 / obj.number_of_iterations;
            
            alpha_value = 1;
            for i = 1:obj.number_of_iterations
                alpha_value = alpha_value - delta_alpha;
                if alpha_value < 0
                    alpha_value = 0;
                end
                alpha(obj.h_plot, alpha_value);

                
                obj.save_frame();
                
                pause(obj.delay);
            end
        end
        
        function move_to_stimulus(obj)
            annotation(...
                obj.h_fig,...
                'textbox',[0.2 0.47 0.1 0.07],...
                'String',{'Stimulus'},...
                'LineWidth',2,...
                'HorizontalAlignment','center',...
                'FontWeight','bold',...
                'FitBoxToText','on',...
                'BackgroundColor',[0.9 0.7 0.1]...
            );


            half_number_of_cols = floor(size(obj.x, 2) / 2);
            mu2 = obj.mu1;
            sigma2 = obj.sigma1;
            delta_sigm2_x = ((2 / 3) * obj.limits(2) / obj.number_of_iterations);
            delta_sigma2 = [delta_sigm2_x, 0; 0, 0];        
            
            for i = 1:obj.number_of_iterations
                cla;

                scale = mvnpdf([0, 0], obj.mu1, obj.sigma1) / mvnpdf([0, 0], mu2, sigma2);
                z2 = mvnpdf([obj.x(:), obj.y(:)], mu2, sigma2);
                z2 = scale * z2;
                z2 = reshape(z2, size(obj.x));

                z = [z2(:, 1:half_number_of_cols), obj.z1(:, half_number_of_cols + 1:end)];

                contour(obj.h_ax, obj.x, obj.y, z, 'LineWidth', 2)
                set(obj.h_ax, 'Visible', 'off');

                obj.save_frame();

                sigma2 = sigma2 + delta_sigma2;
                pause(obj.delay);
            end

        end
        
        function run(obj)
            obj.init();
            
            obj.rotate_camera();           
            obj.transparent_plot();
            obj.move_to_stimulus();
        end
    end
    
    methods (Static)
        
    end
    
end

