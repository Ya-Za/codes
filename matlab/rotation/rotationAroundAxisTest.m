% Init
close('all');
clear();
clc();

% Parameters
a = pi/2;

% Tests
% - 1
disp('Rx');
rotationAroundAxis([1, 0, 0], a)
% - 2
disp('Ry');
rotationAroundAxis([0, 1, 0], a)
% - 3
disp('Rz');
rotationAroundAxis([0, 0, 1], a)