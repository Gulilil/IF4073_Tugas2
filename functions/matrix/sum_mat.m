function result = sum_mat(mat)
    [row, col] = size(mat);
    result = 0;
    for r=1:row
        for c=1:col
            result = result + mat(r,c);
        end
    end
end

