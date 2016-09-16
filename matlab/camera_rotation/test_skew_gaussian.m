%% Init
close all;
clear;
clc;

%% Parameters
limits = [-5, 5];
number_of_points = 100;
sigma = [
    1, 0
    0, 1
];
mu = [0, 0];
alpha = [3, 0];

%%
x = linspace(limits(1), limits(2), number_of_points)';
y = x;
[x, y] = meshgrid(x, y);

z1 = mvnpdf([x(:), y(:)], mu, sigma);
z1 = reshape(z1, size(x));
subplot(1, 3, 1), contour(x, y, z1), shading interp;

z2 = mvnpdf([x(:), y(:)], mu + alpha, sigma);
z2 = reshape(z2, size(x));
subplot(1, 3, 2), contour(x, y, z2), shading interp;

z3 = z1 .* z2;
subplot(1, 3, 3), contour(x, y, z3), shading interp;
