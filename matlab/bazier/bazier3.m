function B = bazier3( t, P )
    %Bazier curve
    % Parameters
    % ----------
    % - t: double
    %   Time between 0 and 1
    % - C: 2-by-n double matrix
    %   Control points
    %
    % Returns
    % -------
    % - B: 2-by-1 vector
    %   Output point

    B = [0, 0]';

    n = size(P, 2);
    for i = 1:n
        B = B + b(t, i - 1, n - 1) * P(:, i);
    end
end

function value = b(t, i, n)
    value = nchoosek(n, i) * t^i * (1 - t)^(n - i);
end

