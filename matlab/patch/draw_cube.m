function draw_cube( scale, translate )
%Draw Cubic

vertices = [
    0 0 0
    0 0 1
    0 1 0
    0 1 1
    1 0 0
    1 0 1
    1 1 0
    1 1 1
];

vertices = vertices .* repmat(scale, size(vertices, 1), 1);
vertices = vertices + repmat(translate, size(vertices, 1), 1);

faces = [
    1 2 4 3
    5 6 8 7
    1 5 6 2
    3 7 8 4
    1 5 7 3
    2 6 8 4
];

patch('Faces', faces, 'Vertices', vertices, 'FaceColor', 'b');
alpha(0.5);
axis('equal');
view(3);

end