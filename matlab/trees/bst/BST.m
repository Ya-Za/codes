classdef BST < handle
    %Binary search tree
    
    properties
        root
    end
    
    methods
        function obj = BST(root)
            obj.root = root;
        end
    end
    
    methods (Static)
        function listOfNodeKeys = inorderTreeWalk(node)
            % Inorder tree walk
            %
            % Parameters
            % ----------
            % - node: BSTNode
            %   Input node
            %
            % Returns
            % -------
            % - listOfNodeKeys: int vector
            %   List of node keys
            
            listOfNodeKeys = [];

            function recursive(x)
                if ~isempty(x)
                    recursive(x.left);
                    listOfNodeKeys(end + 1) = x.key;
                    recursive(x.right);
                end
            end
            
            recursive(node);
        end
        
        function node = treeSearch(root, key)
            % Search tree for finding node which its key equals to given
            % `key'
            %
            % Parameters
            % ----------
            % - root: BSTNode
            %   Root of tree
            % - key: int
            %   Key of target node
            %
            % Returns
            % -------
            % - node: BSTNode
            %   Founded node
            
            function t = recursive(x)
                if isempty(x) || key == x.key
                    t = x;
                    return
                end
                if key < x.key
                    t = recursive(x.left);
                    return
                else
                    t = recursive(x.right);
                    return
                end
            end
            
            node = recursive(root);
        end
        
        function root = iterativeTreeSearch(root, key)
            % Iterative search tree for finding node which its key equals to given
            % `key'
            %
            % Parameters
            % ----------
            % - root: BSTNode
            %   Root of tree
            % - key: int
            %   Key of target node
            %
            % Returns
            % -------
            % - node: BSTNode
            %   Founded node
            
            while ~isempty(root) && key ~= root.key
                if key < root.key
                    root = root.left;
                else
                    root = root.right;
                end
            end
        end
        
        function root = treeMinimum(root)
            % Returns node with minimum `key`
            %
            % Parameters
            % ----------
            % - root: BSTNode
            %   Root of tree
            %
            % Returns
            % -------
            % - node: BSTNode
            %   Founded node
            
            while ~isempty(root.left)
                root = root.left;
            end
        end
        
        function root = treeMaximum(root)
            % Returns node with maximum `key`
            %
            % Parameters
            % ----------
            % - root: BSTNode
            %   Root of tree
            %
            % Returns
            % -------
            % - node: BSTNode
            %   Founded node
            
            while ~isempty(root.right)
                root = root.right;
            end
        end
        
        function successor = treeSuccessor(node)
            % Returns successor of given `node`
            %
            % Parameters
            % ----------
            % - node: BSTNode
            %   Input node
            %
            % Returns
            % -------
            % - successor: BSTNode
            %   Successor of input `node`
            
            if ~isempty(node.right)
                successor = BST.treeMinimum(node.right);
                return
            end
            
            parent = node.parent;
            while ~isempty(parent) && parent.left ~= node
                node = parent;
                parent = node.parent;
            end
            
            successor = parent;
        end
        
        function predecessor = treePredecessor(node)
            % Returns predecessor of given `node`
            %
            % Parameters
            % ----------
            % - node: BSTNode
            %   Input node
            %
            % Returns
            % -------
            % - predecessor: BSTNode
            %   predecessor of input `node`
            
            if ~isempty(node.left)
                predecessor = BST.treeMaximum(node.left);
                return
            end
            
            parent = node.parent;
            while ~isempty(parent) && parent.right ~= node
                node = parent;
                parent = node.parent;
            end
            
            predecessor = parent;
        end
        
        function treeInsert(tree, node)
            % Insert `node` into `tree`
            %
            % Parameters
            % ----------
            % - tree: BST
            %   Input tree
            % - node: BSTNode
            %   Input node
            
            x = tree.root;
            y = [];
            while ~isempty(x)
                y = x;
                if node.key < x.key
                    x = x.left;
                else
                    x = x.right;
                end
            end
            
            node.parent = y;
            
            if isempty(y)
                % tree was empty
                tree.root = node;
            elseif node.key < y.key
                y.left = node;
            else
                y.right = node;
            end
        end
        
        function transplant(tree, u, v)
            % Replace subtree `u` with `v` in given `tree`
            %
            % Parameters
            % ----------
            % - tree: BST
            %   Input tree
            % - u: BSTNode
            %   The root of subtree which have to be removed
            % - v: BSTNode
            %   The root of subtree which have to be inserted
            
            if isempty(u.parent)
                tree.root = v;
            elseif u.parent.left == u
                u.parent.left = v;
            else
                u.parent.right = v;
            end
            
            if ~isempty(v)
                v.parent = u.parent;
            end
        end
        
        function treeDelete(T, z)
            % Delete `node` from `tree`
            %
            % Parameters
            % ----------
            % - T: BST
            %   Input tree
            % - z: BSTNode
            %   Input node
            
            if isempty(z.left)
                BST.transplant(T, z, z.right);
            elseif isempty(z.right)
                BST.transplant(T, z, z.left);
            else
                y = BST.treeMinimum(z.right);
                if y.parent ~= z
                    BST.transplant(T, y, y.right);
                    y.right = z.right;
                    y.right.parent = y;
                end
                BST.transplant(T, z, y);
                y.left = z.left;
                y.left.parent = y;
            end
        end
    end
    
end

