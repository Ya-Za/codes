function pts = get_line_points( p1, p2 )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

dx = p2(1) - p1(1);
dy = p2(2) - p1(2);

% pts = zeros(2, dx + 1);

% for i = 1:(dx + 1)
%     x = p0(1) + (i - 1);
%     y = round(p0(2) + ((i - 1) / dx) * dy);
%     pts(:, i) = [x; y];
% end

pts = [];
if dy < dx
    for x = p1(1): p2(1)
        t = (x - p1(1)) / dx;
        y = (p1(2) + t * dy);
        pts(:, end + 1) = [x; y];
    end
else
    for y = p1(2): p2(2)
        t = (y - p1(2)) / dy;
        x = (p1(1) + t * dx);
        pts(:, end + 1) = [x; y];
    end
end

end

