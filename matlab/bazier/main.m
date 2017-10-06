%% Init
close('all');
clear();
clc();

%% Bazier Curve
controlPoints = [
    1, -1
    -1, 2
    1, 4
    4, 3
    7, 5
]';

numberOfPoints = 100;

points = zeros(2, numberOfPoints);

index = 1;
for t = linspace(0, 1, numberOfPoints)
    points(:, index) = bazier3(t, controlPoints);
    index = index + 1;
end

%% Plot
plot(...
    points(1, :), points(2, :), ...
    'Color', 'blue' ...
);
hold('on');
scatter(...
    controlPoints(1, :), controlPoints(2, :), ...
    'FaceColor', 'red' ...
);
plot(...
    controlPoints(1, :), controlPoints(2, :), ...
    'Color', 'green', ...
    'LineStyle', '--' ...
);
hold('off');

axis('equal');