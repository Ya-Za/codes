classdef A
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id
    end
    
    properties (Constant)
        shared = SharedA()
    end
    
    methods
        
    end
    
    methods (Static)
        function out = setget_var(data)
            persistent var;
            if nargin
                var = data;
            end
            out = var;
        end
    end
    
end
