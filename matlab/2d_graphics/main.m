%% init
close all;
clear;
clc;

%% scale
input_image(:, :, 1) = uint8([1, 2; 3, 4]);
input_image(:, :, 2) = uint8([5, 6; 7, 8]);
input_image(:, :, 3) = uint8([9, 10; 11, 12]);
% input_image = imread('lena_gray.jpg');
% input_image = zeros(4, 4);
sx = 2;
sy = 3;

tic;
output_image = yz_imresize(input_image, sx, sy);
toc;

figure, imshow(input_image), title('Original');
figure, imshow(output_image), title(sprintf('Scaled (%f, %f)', sx, sy));