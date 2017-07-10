classdef InterpTest < matlab.unittest.TestCase
    %Test `Interp` class
    
    properties
    end
    
    properties
        originalPath
        
        x
        y
        xq
    end
    
    methods (TestMethodSetup)
        function addToPath(testCase)
            testCase.originalPath = path();
            [parentFolder, ~, ~] = fileparts(pwd);
            addpath(parentFolder);
        end
        
        function init(testCase)
            % parameters
            xmin = 0;
            xmax = 2*pi;
            func = @(x) sin(x) + sin(2*x) + sin(3*x);
            dx1 = 0.5;
            dx2 = 0.1;
            
            % x, y, xq
            testCase.x = xmin:dx1:xmax;
            testCase.xq = xmin:dx2:xmax;
            testCase.y = func(testCase.x);

            figure('Name', 'Main');
            % plot
            plot(...
                testCase.xq, func(testCase.xq), ...
                'LineStyle', '-', ...
                'Color', 'blue' ...
            );
            
            % scatter
            hold('on');
            scatter(...
                testCase.x, testCase.y, ...
                'FaceColor', 'red' ...
            );
            hold('off');
            axis('tight');
        end
    end
    
    methods (TestMethodTeardown)
        function restorePath(testCase)
            path(testCase.originalPath);
        end
    end
    
    methods (Test)
        function next(testCase)
            % act
            Interp.plot(testCase.x, testCase.y, testCase.xq, 'next');
            % assert
            testCase.assertTrue(true);
        end
        
        function previous(testCase)
            % act
            Interp.plot(testCase.x, testCase.y, testCase.xq, 'previous');
            % assert
            testCase.assertTrue(true);
        end
        
        function nearest(testCase)
            % act
            Interp.plot(testCase.x, testCase.y, testCase.xq, 'nearest');
            % assert
            testCase.assertTrue(true);
        end
        
        function poly(testCase)
            % act
            Interp.plot(testCase.x, testCase.y, testCase.xq, 'poly', 2);
            % assert
            testCase.assertTrue(true);
        end
        
        function spline(testCase)
            % act
            Interp.plot(testCase.x, testCase.y, testCase.xq, 'spline');
            % assert
            testCase.assertTrue(true);
        end
        
        function bazier(testCase)
            % act
            Interp.plot(testCase.x, testCase.y, testCase.xq, 'bazier', 2);
            % assert
            testCase.assertTrue(true);
        end
    end
    
end

