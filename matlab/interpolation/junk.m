function test()
    %TEST
    close('all');
    clear;
    clc;

    delta1 = 0.5;
    delta2 = 0.1;
    x_min = 0;
    x_max = 2*pi;
    func = @sin;

    x = x_min:delta1:x_max;
    y = func(x);

    xq = x_min:delta2:x_max;

    interp_obj = Interp(x, y);
    interp_obj.plot(xq, 'spline');
end

function test_bezier()
   % TEST_BEZIER

   close('all');
   clear;
   clc;

   x = [0, 1];
   y = [0, 1];

   Interp.bezier(x, y);
end

function y = polynomial_vector(a, x)
    % POLYNOMIAL_VECTOR
    %
    % Parameters
    % ----------
    % - a: double vector
    %   Coefficients of polynomial
    % - x: double
    %   Input x
    %
    % Returns
    % - y: double vector
    %   Output value same as `a`

    y = zeros(size(a));
    for i = 1 : length(a)
        y(i) = a(i) * x^(i - 1);
    end
end

function bezier(x, y, dx)
    %BEZIER

    if ~exist('dx', 'var')
        dx = 0.01;
    end

    min_x = min(x);
    max_x = max(x);

    x_ = min_x:dx:max_x;
    y_ = zeros(size(x_));

    n = length(x_);
    for i = 1:n
        alpha = i / n;

        x2 = x;
        y2 = y;
        while length(x2) ~= 1
            x1 = x2;
            y1 = y2;
            x2 = [];
            y2 = [];
            for ii = 1:length(x1)-1
                x2(end + 1) = (1 - alpha) * x1(ii) + alpha * x1(ii + 1);
                y2(end + 1) = (1 - alpha) * y1(ii) + alpha * y1(ii + 1);
            end
        end

        x_(i) = x2(1);
        y_(i) = y2(1);
    end

    % plot
    % - scatter
    scatter(x, y);
    hold('on');

    % - line
    plot(x_, y_);

end

function yq = method_next(obj, xq)
            %METHOD_NEXT
            yq = zeros(size(xq));
            for i = 1 : length(xq)
                [index, ~] = obj.indexof(xq(i));
                yq(i) = obj.y(index);
            end
        end
        
function yq = method_previous(obj, xq)
    %METHOD_PREVIOUS
    yq = zeros(size(xq));
    for i = 1 : length(xq)
        [index, exact] = obj.indexof(xq(i));
        if ~exact
            index = index - 1;
            if index == 0
                index = 1;
            end
        end
        yq(i) = obj.y(index);
    end
end

function yq = method_nearest(obj, xq)
    %METHOD_NEAREST
    yq = zeros(size(xq));
    for i = 1 : length(xq)
        [next, exact] = obj.indexof(xq(i));

        index = next;
        if ~exact
            previous = next - 1;
            if previous ~= 0
                if (xq(i) - obj.x(previous)) <= (obj.x(next) - xq(i))
                     index = previous;
                end
            end
        end

        yq(i) = obj.y(index);
    end
end

function yq = method_linear(obj, xq)
    %METHOD_LINEAR
    % suppose p0=(x0, y0), p1=(x1, y1) and y=a0+a1x1 so we have
    % [1, x0; 1, x1] * [a0; a1] = [y0; y1]

    yq = zeros(size(xq));
    for i = 1 : length(xq)
        [next, ~] = obj.indexof(xq(i));
        previous = next - 1;
        if previous == 0
            yq(i) = obj.y(next);
        else
            x0 = obj.x(previous);
            x1 = obj.x(next);
            y0 = obj.y(previous);
            y1 = obj.y(next);

            yq(i) = ([1, x0; 1, x1] \ [y0; y1])' * [1; xq(i)];
        end
    end
end

function yq = method_spline(obj, xq, n)
    %METHOD_SPLINE
    % suppose p_i=(x_i,y_i) for i = 1..n and y=a_i*x^i for i =
    % 0..(n/2)+1

    if nargin < 3
        n = 5;
    end

    yq = zeros(size(xq));
    len_x = length(obj.x);
    before = floor(n / 2);
    after = n - before - 1;
    for i = 1 : length(xq)
        [index, ~] = obj.indexof(xq(i));

        if (index - before) < 1 || (index + after) > len_x
            yq(i) = obj.y(index);
            continue
        end

        x_ = [];
        y_ = [];
        for ii = -before : after
            x_(end + 1) = obj.x(index + ii);
            y_(end + 1) = obj.y(index + ii);
        end

        A = zeros(n);
        for ii = 1 : n
            for jj = 1: n
                A(ii, jj) = x_(ii)^(jj - 1);
            end
        end

        a = A \ y_';
        xq_ = [];
        for ii = 1 : n
            xq_(end + 1) = xq(i)^(ii - 1);
        end

        yq(i) = xq_ * a;
    end
end

function yq = method_bspline(obj, xq, n)
    %METHOD_BSPLINE
    % suppose p_i=(x_i,y_i) for i = 1..n and y=a_i*x^i for i =
    % 0..(n/2)+1

    if nargin < 3
        n = 4;
    end

    yq = zeros(size(xq));
    len_x = length(obj.x);
    half_n = floor(n / 2);
    for i = 1 : length(xq)
        [index, exact] = obj.indexof(xq(i));

        if exact || (index - half_n) < 1 || (index - 1 + half_n) > len_x
            yq(i) = obj.y(index);
            continue
        end

        x_ = [];
        y_ = [];
        for ii = -half_n : half_n-1
            x_(end + 1) = obj.x(index + ii);
            y_(end + 1) = obj.y(index + ii);
        end

        % A * a = b
        % - A
        A = zeros(n);
        x_previous = x_(half_n);
        x_next = x_(half_n + 1);
        a = ones(n, 1);
        leading_zeros = [];
        for row = 1:2:n
            A(row, :) = [leading_zeros, Interp.polynomial(a, x_previous)];
            A(row + 1, :) = [leading_zeros, Interp.polynomial(a, x_next)];
            a = a(2:end);
            leading_zeros = [leading_zeros, 0];
        end

        % - b
        b = zeros(n, 1);
        for row = 1:2:n
            previous_index = floor(length(y_) / 2);
            next_index = previous_index + 1;
            b(row) = y_(previous_index);
            b(row + 1) = y_(next_index);

            for ii = 2:length(y_)-1
                delta_previous = (y_(ii) - y_(ii - 1)) / (x_(ii) - xx_(ii - 1));
                delta_next = (y_(ii + 1) - y_(ii)) / (x_(ii + 1) - xx_(ii));
                y_(ii) = (delta_previous + delta_next) / 2;

                x_ = x_(2:end-1);
                y_ = y_(2:end-1);
            end
        end

        % - a
        a = A \ b;
        xq_ = zeros(1, n);
        for ii = 1 : n
            xq_(ii) = xq(i)^(ii - 1);
        end

        yq(i) = xq_ * a;
    end
end