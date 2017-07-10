classdef MathTest < matlab.unittest.TestCase
    %Test `Math` class
    
    properties
    end
    
    properties
        originalPath
    end
    
    methods (TestMethodSetup)
        function addToPath(testCase)
            testCase.originalPath = path();
            [parentFolder, ~, ~] = fileparts(pwd);
            addpath(parentFolder);
        end
    end
    
    methods (TestMethodTeardown)
        function restorePath(testCase)
            path(testCase.originalPath);
        end
    end
    
    methods (Test)
        function add(testCase)
            % arrange
            a = 1;
            b = 2;
            expected = 3;
            % act
            actual = Math.add(a, b);
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function sub(testCase)
            % arrange
            a = 1;
            b = 2;
            expected = -1;
            % act
            actual = Math.sub(a, b);
            % assert
            testCase.assertEqual(expected, actual);
        end
    end
    
end

