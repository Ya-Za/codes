function x = yzconv2( u, v, shape)
%YZCONV w = u * v

[h1, w1] = size(u);
[h2, w2] = size(v);

h3 = h1 + h2 - 1;
w3 = w1 + w2 - 1; 

x = zeros(h3, w3);

for i = 1:h3
    for j = 1:w3
        for k = max(1, i + 1 - h2):min(i, h1)
            for l = max(1, j + 1 - w2):min(j, w1)
                x(i, j) = x(i, j) + u(k, l) * v(i - k + 1, j - l + 1);
            end
        end
    end
end

if strcmp(shape, 'valid')
    x = x(h2:h1, w2:w1);
end

if strcmp(shape, 'same')
    begin_index_h = int32((h3 - h1) / 2) + 1;
    end_index_h = begin_index_h + h1 - 1;
    
    begin_index_w = int32((w3 - w1) / 2) + 1;
    end_index_w = begin_index_w + w1 - 1;
    
    x = x(begin_index_h:end_index_h, begin_index_w:end_index_w);
end

end
