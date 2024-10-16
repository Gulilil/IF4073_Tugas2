function img = make_rgb(img)
    [r, c, n_cnl] = size(img);
    if (n_cnl == 1)
        img = repmat(img, [1, 1, 3]);
    end
end

