function [pivot, free] = partitionColumns(A)
    % Partiion columns of 'A' to `pivot` and `free` columns
    [m, n] = size(A);
    pivot = [];
    free = [];
    r = 1;
    for c = 1:n
        if (A(r, c) ~= 0)
            pivot(end + 1) = c;
            r = r + 1;
            if r > m
                break;
            end
        else
            free(end + 1) = c;
        end
    end
    
    for c = c+1:n
        free(end + 1) = c;
    end
end