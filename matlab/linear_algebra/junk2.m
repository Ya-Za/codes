% Init
close('all');
clear();
clc();

%
x1 = rand(2, 1);
x1 = x1 / norm(x1);
x2 = [-x1(2), x1(1)]';
A = rand(3, 2);
y1 = A * x1;
y2 = A * x2;
