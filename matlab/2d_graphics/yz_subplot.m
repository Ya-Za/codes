function yz_subplot( rows, cols )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

figure;
for i = 1:rows * cols
    subplot(rows, cols, i)
end

end

