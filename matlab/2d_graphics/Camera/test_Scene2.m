%% Init
close all;
clear;
clc;

%% Parameters
plane = [1, 5];
width = 2;
aov = 90;

points = [
    0, 5
    0, 6
    1, 5
    -1, 5
];
colors = [
    1, 0, 0
    1, 1, 0
    0, 0, 1
    0, 1, 0
];

% points = [
%     0, 2, 1, 2
%     1, 2, 1, 3
%     1, 3, 0, 3
%     0, 3, 0, 2
% ];
% 
% colors = [
%     1, 0, 0
%     0, 1, 0
%     0, 0, 1
%     1, 1, 0
% ];

%% 
cam = Camera2();

cam.plane = plane;
cam.width = width;
cam.aov = aov;
cam.init();

obj = Object2(points, colors);
scene = Scene2(cam, obj);
