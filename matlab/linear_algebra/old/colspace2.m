function B = colspace2(A)
    % Null space
    R = rref2(A);
    [pivotCols, ~] = partitionColumns(R);
    B = R(:, pivotCols);
    B = orth2(B);
end