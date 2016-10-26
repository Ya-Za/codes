%% Init
close all;
clear;
clc;

%% Parameters
plane = [1, 5];
size_ = [1, 100];
aov = 90;

points = [
    0, 0, 2
    1, 0, 2
];
colors = [
    1, 1, 0
    0, 1, 1
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

% 
cam = Camera3();
cam.plane = plane;
cam.size_ = size_;
cam.aov = aov;
cam.init();

obj = Object3(points, colors);
scene = Scene3(cam, obj);
