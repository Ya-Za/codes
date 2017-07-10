classdef Scene < handle
    %Scene
    
    properties
        elements
    end
    
    methods
        function obj = Scene(elements)
            obj.elements = elements;
        end

        function plot(obj, limits)
            if ~exist('limits', 'var')
                limits = [-10, 10];
            end
            
            numberOfElements = numel(obj.elements);
            for i = 1:numberOfElements
                element = obj.elements{i};
                element.plot();
                
                hold('on');
            end
            
            axis('equal');
            set(gca, ...
                'XLim', limits, ...
                'YLim', limits, ...
                'ZLim', limits, ...
                'XAxisLocation', 'origin', ...
                'YAxisLocation', 'origin' ...
            );
            xlabel('x');
            ylabel('y');
            zlabel('z');
            
            hold('off');
        end
    end
end

