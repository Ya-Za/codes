function w = yzconv( u, v, shape)
%YZCONV w = u * v

m = length(u);
n = length(v);
o = m + n - 1;

w = zeros(1, o);

for k = 1:o
    for j = max(1, k + 1 - n):min(k, m)
        w(k) = w(k) + u(j) * v(k - j + 1);
    end
end

if strcmp(shape, 'valid')
    w = w(n:m);
end

if strcmp(shape, 'same')
    begin_index = int32((o - m) / 2) + 1;
    end_index = begin_index + m - 1;
    w = w(begin_index:end_index);
end

end
