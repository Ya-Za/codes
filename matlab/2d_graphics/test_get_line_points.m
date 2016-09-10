%% Init
%close all;
clear;
clc;

%% Properties
width = 500;
height = 500;
p1 = [0; 0];
p2 = [10; 200];

%% Get points
line = get_line_points(p1, p2);

% transform
% t = [width / 2; -height / 2];
% theta = 45;
% theta = deg2rad(theta);
% R = [cos(theta), -sin(theta)
%      sin(theta),  cos(theta)]; 
%  
% H = [R, t; [0, 0, 1]];
% 
% H = [1, 0, 0; 0, -1, 0; 0, 0, 1] * H; % updown y axis
% 
% line = [line; ones(1, size(line, 2))];
% 
% line = H * line;
% 
% line = line(1:2, :);
% 
% line = round(line);

%% Draw points
image = draw_points(line, width, height);

imtool(image);

image = zeros(width, height);
image = insertShape(image, 'line', [p1', p2'], 'color', 'white');
imtool(image);