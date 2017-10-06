function p = bazier( t, P )
    %Bazier curve
    % Parameters
    % ----------
    % - t: double
    %   Between 0 and 1
    % - P: 2-by-n double matrix
    %   Control points
    %
    % Returns
    % -------
    % - p: 2-by-1 vector
    %   Output point

    while size(P, 2) > 1
        NP = zeros(size(P, 1), size(P, 2) - 1);
        for i = 1:size(NP, 2)
            NP(:, i) = (1 - t) * P(:, i) + t * P(:, i + 1);
        end

        P = NP;
    end

    p = P;
end

