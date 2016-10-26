%% init
close all;
clear;
clc;

%% properties 
line1 = [0, 0, 1, 1];
line2 = [1, 0, 0, 1];

%% plot lines
axis([-5, 5, -5, 5]), grid on, grid minor;
Cam2.draw_lines(line1(1:2), line1(3:4), 'blue');
Cam2.draw_lines(line2(1:2), line2(3:4), 'red');

%% ployxpoly
% [x, y] = polyxpoly([line1.p1(1), line1.p2(1)], [line1.p1(2), line1.p2(2)], [line2.p1(1), line2.p2(1)], [line2.p1(2), line2.p2(2)]);
% 
% disp(x)
% disp(y)

p = Cam2.linexline(line1, line2);

disp(p);