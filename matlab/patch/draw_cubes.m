function draw_cubes( scales, face_colors, face_alpha )
%Draw Cubes

% parameters
font_size = 12;
font_weight = 'bold';

%
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
    draw_cube(scale, center_translate, face_colors(i, :), face_alpha);
    text(...
        -1, (i - 0.5) * N, 0, ...
        sprintf('%dx%dx%d', scale(3), scale(2), scale(1)), ...
        'FontSize', font_size, ...
        'FontWeight', font_weight, ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle' ...
    );
    translate = translate + [0, N, 0];
end

axis('equal');
axis('off');
view(3);

hold('off');

end

