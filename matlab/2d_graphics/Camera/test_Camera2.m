%% Init
close all;
clear;
clc;

%% Properties
n = 10;
limit = 20;
delay = 0.1;



cam2 = Cam2(2, 4);
axis([-limit, limit, -limit, limit]), grid on, grid minor;

% for i = 1:n
%     cla;
%     
%     cam2.t = cam2.t + rand(1, 2);
%     cam2.theta = cam2.theta + 10 * randn;
%     
%     cam2.update_pos();
%     cam2.draw();
%     
%     % pause(delay);
%     pause();
% end

movements = [
    0, 0, 0
    45, 0, 0
    0, 0, 1
    0, 0, 1
    0, 0, 1
];

for i = 1:size(movements, 1)
    cam2.theta = cam2.theta + movements(i, 1);
    cam2.t = cam2.local_to_global(movements(i, 2:3));
    % cam2.t = cam2.t + movements(i, 2:3);
    
    cam2.draw();
    
    % pause(delay);
    pause();
end