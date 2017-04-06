classdef TestUtils < matlab.unittest.TestCase
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
        function test_get_boundary(testCase)
            bw = logical([
                1 1
                0 1
            ]);
            actual_value = Utils.get_boundary(bw);
            
            expected_value = {
                [1, 1]
                [2, 1]
                [2, 2]
            };
            
            testCase.assertEqual(actual_value, expected_value);
        end
        
        function test_get_bounding_box(testCase)
            bw = logical([
                0 0 0 0
                1 1 1 0
                1 1 1 0
            ]);
            actual_value = Utils.get_bounding_box(bw);
            
            expected_value.x = 1;
            expected_value.y = 2;
            expected_value.width = 3;
            expected_value.height = 2;
            
            testCase.assertEqual(actual_value, expected_value);
        end
        
        function test_insert_bounding_box(testCase)
            bw = imread('./b3.bmp');
            Utils.insert_bounding_box(bw);
            
            testCase.assertTrue(true);
        end
        
        function test_angled(testCase)
            u = [1, -1];
            v = [0, 2];
            actual_value = Utils.angled(u, v);
            
            expected_value = 135;
            
            testCase.assertEqual(actual_value, expected_value);
        end
    end
    
end
