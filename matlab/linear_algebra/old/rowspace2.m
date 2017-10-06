function B = rowspace2(A)
    % Null space
    R = rref2(A);
    [pivotRows, ~] = partitionRows(R);
    B = R(pivotRows, :)';
    B = orth2(B);
end