function res_string = display_mat(mat)
    res_string = "";
    [row, col] = size(mat);
    for r=1:row
        if (not (r == 1))
            res_string = res_string+ ";";
        end
        for c=1:col
            res_string = res_string + " " + mat(r,c);
        end
    end
end

