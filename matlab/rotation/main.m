%% Init
close('all');
clear();
clc();


%% Scene
limits = [-5, 5];
% axes
ax = Axes();
% camera
camera = Axes();
camera.translate([2, 0, 0]);
camera.orbit([0, 0, 0], 180, 'z');

% scene
scene = Scene({ax, camera});

%% Plot
hold('on');

scene.plot();

axis('equal');
set(gca, ...
    'XLim', limits, ...
    'YLim', limits, ...
    'ZLim', limits, ...
    'XAxisLocation', 'origin', ...
    'YAxisLocation', 'origin' ...
);
xlabel('x');
ylabel('y');
zlabel('z');
