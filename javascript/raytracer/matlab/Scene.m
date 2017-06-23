classdef Scene < Plotable
    %Scene
    
    properties
        elements
    end
    
    methods
        function obj = Scene(elements)
            obj.elements = elements;
        end

        function plot(obj)
            numberOfElements = numel(obj.elements);
            for i = 1:numberOfElements
                element = obj.elements{i};
                
                element.plot();
            end
        end
    end
end

