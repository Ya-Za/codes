classdef ClassA < handle
    %UNTITLED22 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        marriage
    end
    
    methods
        function obj = ClassA()
            obj.marriage = false;
        end
        
        function set_marriage(obj, value)
            if obj.marriage == value
                return
            end
            
            obj.marriage = value;
            notify(obj, 'ToggleMarriage');
        end
    end
    
    events
        ToggleMarriage
    end
    
end

