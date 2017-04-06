classdef TestPolygonFilling < matlab.unittest.TestCase
    %TESTPOLYGONFILLING
    
    properties
        original_path
    end
    
    methods (TestMethodSetup)
        function add_to_path(testCase)
            testCase.original_path = path;
            [parent_folder, ~, ~] = fileparts(pwd);
            addpath(fullfile(parent_folder));
        end
    end
    
    methods (TestMethodTeardown)
        function restore_path(testCase)
            path(testCase.original_path);
        end
    end
    
    methods (Test)
        function test_get_neighbours(testCase)
            point = [0, 0];
            actual_value = PolygonFilling.get_neighbours(point);
            
            expected_value = {
                [0, -1]
                [1, 0]
                [0, 1]
                [-1, 0]
            };
            
            testCase.assertEqual(actual_value, expected_value);
        end
        
        function test_validate_neighbours(testCase)
            neighbours = {
                [0, 1]
                [1, 0]
                [201, 1]
                [1, 101]
            };
            height = 100;
            width = 200;
            
            actual_value = PolygonFilling.validate_neighbours(...
                neighbours, ...
                height, ...
                width ...
            );
        
            expected_value = {};
        
            testCase.assertEqual(actual_value, expected_value);
        end
        
        function test_floodfill(testCase)
            bw = imread('b1.bmp');
            in_point = [100, 50];
            
            % PolygonFilling.floodfill(bw, in_point);
            
            testCase.assertTrue(true);
        end
        
        function test_scanline(testCase)
            bw = imread('b3.bmp');
            
            % PolygonFilling.scanline(bw);
            testCase.assertTrue(true);
        end
    end
    
end

