% Init
close('all');
clear();
clc();

%
A = [1, 0; 2, 0]
x = [2, 3]'
y = A * x

r = A * inv(A * A') * y
