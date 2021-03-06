%%
close('all');
clear();
clc();

%%
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
bst = BST(n6);
% save
save('bst', 'bst');
% inorder tree walk
BST.inorderTreeWalk(bst.root);
fprintf('\n');
