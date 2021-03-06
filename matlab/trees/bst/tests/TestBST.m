classdef TestBST < matlab.unittest.TestCase
    
    properties
        originalPath
        bst
    end
    
    methods (TestMethodSetup)
        function addToPath(testCase)
            % Add `parent` of current directory to the `path` of matlab
            
            % save original path
            testCase.originalPath = path;
            
            % add `..` to the path
            [parentFolder, ~, ~] = fileparts(pwd);
            addpath(parentFolder);
        end
        
        function initBST(testCase)
            % nodes
            n6 = BSTNode(6);
            n5_1 = BSTNode(5);
            n7 = BSTNode(7);
            n2 = BSTNode(2);
            n5_2 = BSTNode(5);
            n8 = BSTNode(8);
            % connections
            n6.left = n5_1;
            n6.right = n7;

            n5_1.parent = n6;
            n5_1.left = n2;
            n5_1.right = n5_2;

            n7.parent = n6;
            n7.right = n8;

            n2.parent = n5_1;

            n5_2.parent = n5_1;

            n8.parent = n7;
            % tree
            testCase.bst = BST(n6);
        end
    end
    
    methods (TestMethodTeardown)
        function restorePath(testCase)
            % Restore original path
            path(testCase.originalPath);
        end
    end
    
    methods (Test)
        function test_inorderTreeWalk(testCase)
            % arrange
            expected = [2, 5, 5, 6, 7, 8];
            % act
            actual = BST.inorderTreeWalk(testCase.bst.root);
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treeSearch(testCase)
            % arrange
            key = 8;
            expected = 8;
            % act
            node = BST.treeSearch(testCase.bst.root, key);
            actual = node.key;
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_iterativeTreeSearch(testCase)
            % arrange
            key = 8;
            expected = 8;
            % act
            node = BST.iterativeTreeSearch(testCase.bst.root, key);
            actual = node.key;
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treeMinimum(testCase)
            % arrange
            expected = 2;
            % act
            node = BST.treeMinimum(testCase.bst.root);
            actual = node.key;
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treeMaximum(testCase)
            % arrange
            expected = 8;
            % act
            node = BST.treeMaximum(testCase.bst.root);
            actual = node.key;
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treeSuccessor(testCase)
            % arrange
            expected = 6;
            % act
            node = BST.treeSuccessor(testCase.bst.root.left.right);
            actual = node.key;
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treePredecessor(testCase)
            % arrange
            expected = 6;
            % act
            node = BST.treePredecessor(testCase.bst.root.right);
            actual = node.key;
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treeInsert(testCase)
            % arrange
            node = BSTNode(9);
            expected = [2, 5, 5, 6, 7, 8, 9];
            % act
            BST.treeInsert(testCase.bst, node);
            actual = BST.inorderTreeWalk(testCase.bst.root);
            % assert
            testCase.assertEqual(expected, actual);
        end
        
        function test_treeDelete(testCase)
            % arrange
            node = BST.treeSearch(testCase.bst.root, 5);
            expected = [2, 5, 6, 7, 8];
            % act
            BST.treeDelete(testCase.bst, node);
            actual = BST.inorderTreeWalk(testCase.bst.root);
            % assert
            testCase.assertEqual(expected, actual);
        end
    end
    
end
