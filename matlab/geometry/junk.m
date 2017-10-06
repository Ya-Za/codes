close('all');
clear();
clc();

% P = [
%     0 0
%     0 1
%     1 0
%     1 1
%     -1 -1
%     -1 2
%     2 2
%     2 -1
% ];
% 
% x = P(:, 1);
% y = P(:, 2);
% 
% tri = delaunay(x,y);
% hold on, triplot(tri,x,y), hold off

% A = polyarea(x, y)



% Ax = {[1 1 6 6 1], [2 5 5 2 2], [2 5 5 2 2]};
% Ay = {[1 6 6 1 1], [2 2 3 3 2], [4 4 5 5 4]};
% subplot(2, 3, 1)
% [f, v] = poly2fv(Ax, Ay);
% 
% G2.plotTriangles(v, f);

P = [
    0 0
    1 0
    0.5 0.5
    1 1
    0 1
];

[f, v] = poly2fv(P(:, 1), P(:, 2));
G2.plotTriangles(v, f);