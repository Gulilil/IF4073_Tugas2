function [local_mat] = get_local_mat(img, row, col, n)
    % n should be an odd number
    pixel_window = floor(n/2);
    
    local_mat = [];
    for r=row-pixel_window:row+pixel_window
        local_line = img(r, col-pixel_window:col+pixel_window);
        local_mat = [local_mat; local_line];
    end
end

