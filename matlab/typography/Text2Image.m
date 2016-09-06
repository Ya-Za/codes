classdef Text2Image < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        text
        font_family
        font_scale
        background_color
        foreground_color
    end
    
    methods
        function obj = Text2Image(text)
            obj.text = text;
            obj.font_family = FontFamily.make_font_family('random_walk', @FontFamily.make_random_walk_image, 0.1);
            obj.font_scale = 1;
            obj.background_color = [1, 1, 1];
            obj.foreground_color = [0, 0, 0];
        end
        
        function image = run(obj)
            image = [];
            for c = obj.text
                image = [image, obj.font_family.chars{uint8(c) + 1}];
            end
        end
    end
    
end

