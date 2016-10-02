%Init
close all;
clear;
clc;

%% Properties
width = 505;
height = 505;
m = 3;
n = 3;

%% 
image = subplot_boxes(m, n, width, height);
imshow(image);