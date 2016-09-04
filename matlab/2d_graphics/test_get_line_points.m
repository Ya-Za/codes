%% init
close all;
clear;
clc;

%%
width = 500;
height = 500;
image = zeros(width, height, 'uint8');

line = get_line_points([0; 0], [200; 0]);

% transform
t = [width / 2; -height / 2];
theta = 45;
theta = deg2rad(theta);
R = [cos(theta), -sin(theta)
     sin(theta),  cos(theta)]; 
 
H = [R, t; [0, 0, 1]];

H = [1, 0, 0; 0, -1, 0; 0, 0, 1] * H; % updown y axis

line = [line; ones(1, size(line, 2))];

line = H * line;

line = line(1:2, :);

line = round(line);

% for i = 1:size(line, 2)
%     line(:, i) = line(:, i) + t;
%     % line(2, i) = height - line(2, i);
%     line(2, i) = -1 * line(2, i);
% end

% draw line
for i = 1:size(line, 2)
    image(line(2, i) + 1, line(1, i) + 1) = 255;
end

imshow(image);