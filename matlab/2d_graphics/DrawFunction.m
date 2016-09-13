classdef DrawFunction < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        limits
        
        h_figure
        h_axes
    end
    
    methods
        function obj = DrawFunction(limits)
            obj.limits = limits;
            
            obj.init();
        end
        
        function init(obj)
            obj.h_figure = figure('Name', 'Draw Function', 'NumberTitle', 'off');
            obj.h_axes = axes();
            axis(obj.h_axes, obj.limits), grid on, grid minor;
            
            set(obj.h_figure, 'WindowButtonMotionFcn', @obj.mouse_move);
        end
        
        function mouse_move (obj, hObject, ~)
            st = get(obj.h_figure,'SelectionType');
            if ~strcmp(st, 'alt')
                return
            end
            
            cp = get(obj.h_axes, 'CurrentPoint');

            x = cp(1, 1);
            if x < obj.limits(1) || x > obj.limits(2)
                return;
            end

            y = cp(1, 2);
            if y < obj.limits(3) || y > obj.limits(4)
                return
            end

            title(obj.h_axes, ['(X,Y) = (', num2str(x), ', ',num2str(y), ')']);
        end
    end
end

