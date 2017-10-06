function R = rref2(A)
    % Reduced row echelon form (Gauss-Jordan elimination)
    roundDigits = 3;
    R = A;
    % R = round(A, roundDigits);
    [numberOfRows, numberOfColumns] = size(A);
    % current row
    for currentRowIndex = 1:numberOfRows
        targetRowIndex = currentRowIndex;
        [pivotValue, pivotIndex] = pivot(currentRowIndex);
        for rowIndex = currentRowIndex + 1:numberOfRows
            [pv, pi] = pivot(rowIndex);
            if pi < pivotIndex
                targetRowIndex = rowIndex;
                pivotIndex = pi;
                pivotValue = pv;
            end
        end
        
        if pivotValue == 0
            break;
        end
        
        if currentRowIndex ~= targetRowIndex
            swap(currentRowIndex, targetRowIndex);
        end
        
        mul(currentRowIndex, 1/pivotValue);
        
        for rowIndex = 1:numberOfRows
            if rowIndex == currentRowIndex
                continue;
            end
            
            value = R(rowIndex, pivotIndex);
            if value == 0 
                continue;
            end
            
            add(currentRowIndex, -value, rowIndex);
        end
    end

    % Local functions
    function row = getRow(rowIndex)
        row = R(rowIndex, :);
    end
    function setRow(rowIndex, row)
        R(rowIndex, :) = row;
    end
    function swap(firstRowIndex, secondRowIndex)
        tmp = getRow(firstRowIndex);
        setRow(firstRowIndex, getRow(secondRowIndex));
        setRow(secondRowIndex, tmp);
    end
    function mul(rowIndex, scalar)
        setRow(rowIndex, scalar * getRow(rowIndex));
    end
    function add(sourceRowIndex, scalar, targetRowIndex)
        setRow(...
            targetRowIndex, ...
            getRow(targetRowIndex) + scalar * getRow(sourceRowIndex) ...
        );
    end
    function [pivotValue, pivotIndex] = pivot(rowIndex)
        pivotValue = 0;
        for pivotIndex = 1:numberOfColumns
            pivotValue = R(rowIndex, pivotIndex);
            if pivotValue ~= 0
                break; 
            end
        end
        if pivotValue == 0
            pivotIndex = numberOfColumns + 1;
        end
    end
end