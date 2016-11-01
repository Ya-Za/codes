function res = six_two( A )
% Q 6.2

res = 0;
threshold = 1 + size(A, 1);
for i = 1:size(A, 1)
    for j = 1:size(A, 2)
        if (i + j) >= threshold
            res = res + A(i, j);
        end
    end
end


end

