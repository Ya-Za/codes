%% init
close all;
clear;
clc;

%% 
width = 500;
height = 500;

t = [width / 2; height / 2];
theta = 30;
R = [cosd(theta), -sind(theta); sind(theta), cosd(theta)];

transform = @(x) R * x + t;

% circle
circle.c = [0; 0];
circle.r = 50;

% rectangle
rect.x = -50;
rect.y = -50;
rect.width = 100;
rect.height = 100;


%%

image = zeros(width, height, 'uint8');

% image = insertShape(image,'circle', [transform(circle.c); circle.r]', 'color', [255, 255, 255]);
image = insertShape(image,'rectangle', [transform([rect.x; rect.y]); rect.width; rect.height]', 'color', [255, 255, 255]);

imshow(image);