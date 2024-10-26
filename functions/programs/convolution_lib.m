function result_img = convolution_lib(img, mask, n_mask)
    sum = sum_mat(mask);
    if (not(sum == 0))
        mask = mask / sum;
    end

    [row, col, num_channels] = size(img);
    result_img = zeros(row, col, num_channels, 'uint8'); % Same size as the original image

    for channel = 1:num_channels
        % Perform convolution on the current channel
        result_img(:, :, channel) = conv2(double(img(:, :, channel)), mask, 'same');
    end
   
end

