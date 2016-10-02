% Init
close all;
clear;
clc;

%%
axis([-5, 5, -5, 5]);
set (gcf, 'WindowButtonMotionFcn', @mouse_move);
% set (gcf, 'WindowButtonDownFcn', @mouseMove);