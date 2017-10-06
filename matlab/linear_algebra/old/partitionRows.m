function [pivot, free] = partitionRows(A)
    % Partiion rows of 'A' to `pivot` and `free` columns
    [m, n] = size(A);
    zeroRow = zeros(1, n);
    r = 1;
    while true
        if r > m
            break;
        end
        if all(A(r, :) == zeroRow)
            break;
        end
        
        r = r + 1;
    end
    
    pivot = 1:(r - 1);
    free = r:m;
end