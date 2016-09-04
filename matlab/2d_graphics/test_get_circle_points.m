%% init
close all;
clear;
clc;

%%
width = 500;
height = 500;
center = [100; 100];
radius = 50;

% canvas
canvas = zeros(height, width, 'uint8');

% circle
circle = get_circle_points(center, radius);

t = [width / 2; -height / 2];
R = eye(2);
H = [R, t; [0, 0, 1]];
H = [1, 0, 0; 0, -1, 0; 0, 0, 1] * H;

circle = [circle; ones(1, size(circle, 2))];
circle = H * circle;
circle = circle(1:2, :);

% draw circle
for p = circle
    canvas(p(2) + 1, p(1) + 1) = 255;
end

imshow(canvas);
