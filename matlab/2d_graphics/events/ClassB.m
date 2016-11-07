classdef ClassB < handle
    %UNTITLED23 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = ClassB(class_a)
            addlistener(class_a, 'ToggleMarriage', @ClassB.handle_event);
        end
    end
    
    methods (Static)
        function handle_event(src, ~)
            if src.marriage
                disp('Congradulations :)')
            else
                disp('Don''worry, You can find another wife :(');
            end
        end
    end
    
end

