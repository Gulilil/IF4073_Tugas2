function result = is_border_pixel(img, r, c, pixel_border)
    [row, col, n_channels] = size(img);
    result = false;
    if (r <= pixel_border || r >= row+1-pixel_border)
        result = true;
    end
    if (c <= pixel_border || c >= col+1-pixel_border)
        result = true;
    end
end

