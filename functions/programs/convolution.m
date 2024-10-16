function result_img = convolution(img, is_grayscaled)
    [row, col, num_channels] = size(img);

    % Insert the mask matrix
    [mask, n_mask] = read_mask();
    pixel_border = floor(n_mask/2);
    sum_mask = sum_mat(mask);

    % Img details
    fprintf("[INFO] An image size [%d, %d] is inputted!\n", row, col);
    
    % Create placeholder for new image
    if (num_channels == 1 | is_grayscaled)
        fprintf("[PROCESS] Processing grayscale image!\n");
        if (not(num_channels == 1))
            % If full colored but want to be grayscaled
            img = rgb2gray(img);
        end
        is_gray = true;
        result_img = zeros(row, col, 1, 'uint8');
    else
        fprintf("[PROCESS] Processing full color image!\n");
        is_gray = false;
        result_img = zeros(row, col, 3, 'uint8');
    end

    % Create image
    for r=1:row
        for c =1:col
            if (is_gray)
                % For border
                % Do not convolute border pixels
                if (is_border_pixel(img, r, c, pixel_border))
                    result_img(r, c) = img(r, c);
                else
                    local_mat = get_local_mat(img, r, c, n_mask);
                    conv_result = round(dot_product(local_mat, mask)/sum_mask);
                    result_img(r,c) = conv_result;
                end
            else % For coloured image
                disp(r);
                disp(c);
                red_channel = img(:, :, 1);   % Red channel
                green_channel = img(:, :, 2); % Green channel
                blue_channel = img(:, :, 3);  % Blue channel
                % For border
                % Do not convolute border pixels
                if (is_border_pixel(img, r, c, pixel_border))
                    result_img(r, c, 1) = red_channel(r, c);
                    result_img(r, c, 2) = green_channel(r, c);
                    result_img(r, c, 3) = blue_channel(r, c);
                else
                    local_mat_red = get_local_mat(red_channel, r, c, n_mask);
                    conv_result_red = round(dot_product(local_mat_red, mask)/sum_mask);
                    result_img(r, c, 1) = conv_result_red;

                    local_mat_green = get_local_mat(green_channel, r, c, n_mask);
                    conv_result_green = round(dot_product(local_mat_green, mask)/sum_mask);
                    result_img(r, c, 2) = conv_result_green;

                    local_mat_blue = get_local_mat(blue_channel, r, c, n_mask);
                    conv_result_blue = round(dot_product(local_mat_blue, mask)/sum_mask);
                    result_img(r, c, 3) = conv_result_blue;
                end

            end
        end
        %if (mod(r, row /72) == 0)
        %   disp("[CHECKPOINT]");
        %end
    end
    disp("[FINISHED] Finish processing!");
end

