%% Init
close all;
clear;
clc;

%% Properties
limits = [-1, 1, -1, 1];

%% 
df = DrawFunction();
df.limits = limits;
df.run();