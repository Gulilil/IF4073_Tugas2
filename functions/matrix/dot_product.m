function result = dot_product(mat1, mat2)
    [row1, col1] = size(mat1);
    [row2, col2] = size(mat2);
    result = 0;
    if (not (row1 == row2) || not (col1 == col2) )
        disp("Both matrix is not equal in shape!");
        result = [];
    else
        for r=1:row1
            for c=1:col1
               result = result + mat1(r, c) * mat2(r, c);
            end
        end
    end
end

