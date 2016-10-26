function image = draw_points( points, width, height )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

image = zeros(height, width);

for i = 1:size(points, 2)
    x = get_int_fraction_parts(points(1, i));
    y = get_int_fraction_parts(points(2, i));
    
%     % int
%     image(y.int, x.int) = 1;
%     
%     % fraction
%     if x.frac ~= 0 && y.frac ~= 0
%         image(y.int + 1, x.int + 1) = x.frac * y.frac;
%     end
%     if x.frac ~=0 && y.frac == 0
%         image(y.int, x.int + 1) = x.frac; 
%     end
%     if x.frac == 0 && y.frac ~= 0
%         image(y.int + 1, x.int) = y.frac;
%     end

    image(y.int,        x.int    ) = (1 - y.frac)   *   (1 - x.frac);
    image(y.int + 1,    x.int    ) = y.frac         *   (1 - x.frac);
    image(y.int,        x.int + 1) = (1 - y.frac)   *   x.frac;
    image(y.int + 1,    x.int + 1) = y.frac         *   x.frac;
end

end

function x = get_int_fraction_parts(u)
    x.int = floor(u) + 1;
    x.frac = u - floor(u);
end
