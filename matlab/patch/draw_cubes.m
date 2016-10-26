function draw_cubes( scales )
%Draw Cubes

figure('Name', 'Cubes', 'NumberTitle', 'off', 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
hold('on');

M = scales(1, 1);
N = scales(1, 2);
scales = flip(scales, 1);
scales = scales(:, [3, 2, 1]);

translate = [0, 0, 0];
for i = 1:size(scales, 1)
    scale = scales(i, :);
    center_translate = ...
        translate + ...
        [0, floor((N - scale(2)) / 2), floor((M - scale(3)) / 2)];
    draw_cube(scale, center_translate);
    text(-1, (i - 0.5) * N, 0, sprintf('%dx%dx%d', scale(3), scale(2), scale(1)), 'HorizontalAlignment', 'center' , 'VerticalAlignment', 'middle');
    translate = translate + [0, N, 0];
end
alpha(0.5);
axis('equal');
axis('off');
view(3);

hold('off');

end

