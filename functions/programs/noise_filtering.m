function [result_img, img_with_noise] = noise_filtering(img, noise_type, filter_type, n_window, density, mean, variance)
    
    if (noise_type == "Salt and Pepper")
        img_with_noise = imnoise(img, 'salt & pepper', density);
    else % noise_type == "Gaussian"
        img_with_noise = imnoise(img, 'gaussian', mean, variance);
    end

    [row, col, num_channels] = size(img);
    pixel_border = floor(n_window/2);   

    % Img details
    fprintf("[INFO] An image size [%d, %d] is inputted!\n", row, col);
    
    % Create placeholder for new image
    if (num_channels == 1)
        fprintf("[PROCESS] Processing grayscale image!\n");
        is_gray = true;
        result_img = zeros(row, col, num_channels, 'uint8');
    else
        fprintf("[PROCESS] Processing full color image!\n");
        is_gray = false;
        result_img = zeros(row, col, num_channels, 'uint8');
    end

    % Create image
    for channel = 1: num_channels
        channel_result = zeros(row, col);
        img_channel = img(:, :, channel);   % Each Color channel

        parfor r=1:row
            rowResult = zeros(1, col);

            for c=1:col
                % For border
                % If pixel is in border, set it to black (0)
                if (is_border_pixel(img_channel, r, c, pixel_border))
                    rowResult(c) = 0;  % Set to black
                else
                    local_mat = get_local_mat(img_channel, r, c, n_window);
                    conv_result = validate_pixel(round(noise_filter_process(local_mat, filter_type)));
                    rowResult(c) = conv_result;
                end
            end
            channel_result(r, :) = rowResult;
        end
        result_img(:,:, channel) = channel_result;
    end
    disp("[FINISHED] Finish processing!");
end

