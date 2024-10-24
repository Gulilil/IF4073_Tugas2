function result = sum_mat(mat)
    [row, col] = size(mat);
    result = 0;
    disp(mat);
    for r=1:row
        for c=1:col
            disp(mat(r,c));
            result = result + mat(r,c);
        end
    end
end

