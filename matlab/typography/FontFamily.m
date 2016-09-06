classdef FontFamily < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        chars
        height
    end
    
    methods
        function obj = FontFamily(name)
            obj.name = name;
            obj.chars = [];
            obj.height = 20;
        end
    end
    
    methods (Static)
        function ff = make_font_family(name, method, percent)
            ff = FontFamily(name);
            % ff.chars = randi([0, 1], ff.height, ff.height, 256);
            for i = 1:256
                width = round((ff.height / 2)) + randi(ff.height);
                
                ff.chars{end + 1} = method(width, ff.height, percent);
            end
        end
        
        function image = make_random_image(width, height, percent)
            % image = randi([0, 1], height, width);
            
            image = ones(height, width);
            n = round(percent * height * width);
            
            for i = 1:n
                current_pose = [randi(width), randi(height)];
                image(current_pose(2), current_pose(1)) = 0;    
            end
        end
        
        function image = make_random_walk_image(width, height, percent)
            image = ones(height, width);
            current_pose = [randi(width), randi(height)];
            n = round(percent * height * width);
            for i = 2:n
                image(current_pose(2), current_pose(1)) = 0;
                current_pose = current_pose + [randi([-1, 1]), randi([-1, 1])];
                
                if current_pose(1) < 1
                    current_pose(1) = 1;
                end
                if current_pose(1) > width
                    current_pose(1) = width;
                end
                
                if current_pose(2) < 1
                    current_pose(2) = 1;
                end
                if current_pose(2) > height
                    current_pose(2) = height;
                end
            end
        end
    end
    
end

