function Q = orth2(A)
    % Orthonormal basis for range of matrix
    Q = A;
    Q(:, 1) = A(:, 1) / norm(A(:, 1));
    
    numberOfColumns = size(A, 2);
    for c = 2:numberOfColumns
        col = A(:, c);
        col = col - proj(col, Q(:, 1:c-1));
        col = col / norm(col);
        Q(:, c) = col;
    end
    
end

function p = proj(x, A)
    % Projection of `x` on columnspace of 'A'
    p = A * inv(A' * A) * A' * x;
end