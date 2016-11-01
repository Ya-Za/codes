% Init
close('all');
clear;
clc;

%% Parameters
scales = [
    10, 10, 10
    2, 2, 2
    8 8 9
];

face_colors = rand(size(scales, 1), 3);
face_alpha = 1;

%% Draw cubes
draw_cubes(scales, face_colors, face_alpha);