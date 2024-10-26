function result = noise_filter_process(mat, filter_type)
    len = length(mat) * length(mat);
    % filter_type = ["Min", "Max", "Median", "Arithmetic Mean", "Geometric Mean", "Harmonic Mean", "Contraharmonic Mean", "Midpoint", "Alpha-trimmed Mean"];
    if(filter_type == "Min")
       result = min(mat(:));
    elseif(filter_type == "Max")
        result= max(mat(:));
    elseif(filter_type == "Median")
        result = median(mat(:));
    elseif(filter_type == "Arithmetic Mean")
        result = mean(mat(:));
    elseif(filter_type == "Geometric Mean")
        result = prod(mat(:))^(1/len); 
    elseif(filter_type == "Harmonic Mean")
        mat(mat == 0) = 1; % To prevent devide by 0
        result = len / sum(1 ./ double(mat(:)));
    elseif(filter_type == "Contraharmonic Mean")
        if (sum(mat(:)) == 0)
            result = mean(mat(:)); % To prevent error
        else
            result = sum(mat(:) .^ 2) / sum(mat(:));
        end
    elseif(filter_type == "Midpoint")
        result = 1/2 * ( min(mat(:)) + max(mat(:)) );
    elseif(filter_type == "Alpha-trimmed Mean")
        sorted_mat = sort(mat(:));
        alpha = 0.2;
        n_delete = round(len * (alpha/2));
        result = mean(sorted_mat(1+n_delete:len-n_delete));
    end
end

