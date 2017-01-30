classdef Test01 < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Test)
        function test01(testCase)
            testCase.verifyTrue(false);
            testCase.verifyTrue(true);
        end
        
        function test02(testCase)
            testCase.assertTrue(true);
        end
    end
    
end

