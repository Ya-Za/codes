classdef Product < handle
    %PRODUCT makes all possible cartesian product
    %   >>> obj = Product([1, 2], [3, 4])
    %   >>> obj.values
    %   1 2
    %   1 4
    %   2 3
    %   2 4
    
    properties
        lists
        value
        values
    end
    
    methods
        function obj = Product(lists)
            obj.lists = lists;
            obj.value = zeros(1, length(lists));
            obj.values = [];
            
            obj.next(1);
        end
        
        function next(obj, index)
            if index > length(obj.value)
                obj.values(end + 1, :) = obj.value;
                return;
            end
            for x = obj.lists{index}
                obj.value(index) = x;
                obj.next(index + 1)
            end
        end
    end
    
end

