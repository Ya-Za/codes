%% Init
close('all');
clear;
clc;

%%
figure;
format('compact');
axes('Position',[0.2 0.2 0.6 0.6]);
% vert = [1 1 -1; 
%         -1 1 -1; 
%         -1 1 1; 
%         1 1 1; 
%         -1 -1 1;
%         1 -1 1; 
%         1 -1 -1;
%         -1 -1 -1];
%     
%  vert = vert + repmat([1, 1, 1], 8, 1);
%  vert = vert / 2;

vert = [
    0 0 0
    0 0 1
    0 1 0
    0 1 1
    1 0 0
    1 0 1
    1 1 0
    1 1 1
];

% fac = [1 2 3 4; 
%        4 3 5 6; 
%        6 7 8 5; 
%        1 2 8 7; 
%        6 7 1 4; 
%        2 3 5 8];

fac = [
    1 2 4 3
    5 6 8 7
    1 5 6 2
    3 7 8 4
    1 5 7 3
    2 6 8 4
];

% I defined a new cube whose length is 1 and centers at the origin.
vert2 = vert * 0.5;  
fac2 = fac;

patch('Faces',fac,'Vertices',vert,'FaceColor','b');  % patch function
% axis([-1, 1, -1, 1, -1, 1]);
xlabel('x');
ylabel('y');
zlabel('z');
axis('equal');
alpha(0.5);
% alphamap('rampdown');
hold on;

patch('Faces', fac2, 'Vertices', vert2, 'FaceColor', 'r');
% material('metal');

%view(3);