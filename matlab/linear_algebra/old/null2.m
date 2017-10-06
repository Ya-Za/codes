function B = null2(A)
    % Null space
    numberOfCols = size(A, 2);
    R = rref2(A);
    [pivotCols, freeCols] = partitionColumns(R);
    
    rank = length(pivotCols);
    nullity = length(freeCols);
    B = zeros(size(A, 2), nullity);
    if nullity == 0
        return;
    end
    for i = 1:nullity
        freeColIndex = freeCols(i);
        col = zeros(numberOfCols, 1);
        col(freeColIndex) = 1;
        for j = 1:rank
            pivotColIndex = pivotCols(j);
            col(pivotColIndex) = -R(j, freeColIndex);
        end
        B(:, i) = col;
    end
    
    B = orth2(B);
end
