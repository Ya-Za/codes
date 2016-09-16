%% Init
close all;
clear;
clc;

%% Parameters
limits = [-5, 5];
number_of_points = 100;
sigma = 1;
mu = 1;

%%
x = linspace(limits(1), limits(2), number_of_points)';
y1 = gaussian(x, mu, sigma);
y2 = normpdf(x, mu, sigma);

subplot(1, 2, 1), plot(x, y1, 'Color', 'blue');
subplot(1, 2, 2), plot(x, y2, 'Color', 'red');