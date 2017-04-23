classdef BSTNode < handle
    %Binary search tree node
    
    properties
        key
        left
        right
        parent
    end
    
    methods
        function obj = BSTNode(key)
            obj.key = key;
            obj.left = [];
            obj.right = [];
            obj.parent = [];
        end
    end
    
end

