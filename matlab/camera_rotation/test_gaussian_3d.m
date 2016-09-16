%% Init
close all;
clear;
clc;

%% Parameters
limits = [-5, 5];
number_of_points = 100;
sigma = [
    2, 1
    1, 3
];
mu = [0, 0];

%%
x = linspace(limits(1), limits(2), number_of_points)';
y = x;
[x, y] = meshgrid(x, y);

z1 = gaussian([x(:), y(:)], mu, sigma);
z1 = reshape(z1, size(x));

z2 = mvnpdf([x(:), y(:)], mu, sigma);
z2 = reshape(z2, size(x));

subplot(1, 2, 1), surf(x, y, z1), shading interp;
subplot(1, 2, 2), surf(x, y, z2), shading interp;

%% contour
figure;
contour(x, y, z1);