%% Init
close all;
clear;
clc;

%% Parameters
limits = [-5, 5];
number_of_points = 100;
sigma1 = [
    1, 0
    0, 1
];
mu1 = [0, 0];

number_of_iterations = 20;

delay = 0.3;

dir_path = './frames';
outpu_video_file_name = 'video';
frame_rate = 5;
save_frames = true;

%% Run
attention = Attention();

attention.limits = limits;
attention.number_of_points = number_of_points;
attention.sigma1 = sigma1;
attention.mu1 = mu1;
attention.number_of_iterations = number_of_iterations;
attention.delay = delay;
attention.dir_path = dir_path;
attention.save_frames = save_frames;

attention.run();

%% Movie
make_frames_to_video(dir_path, outpu_video_file_name, frame_rate);