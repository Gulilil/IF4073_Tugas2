function result_img = convolution(img, is_grayscaled, typeMask, nMask)
    % Set default values for optional parameters
    if nargin < 3 || isempty(typeMask)
        typeMask = 'readFile'; % Set a default mask type
    end
    
    if nargin < 4 || isempty(nMask)
        nMask = 0; % Default mask size, for example a 3x3 mask
    end
    
    [row, col, num_channels] = size(img);

    % Insert the mask matrix
    if strcmp(typeMask, 'readFile')
        [mask, n_mask] = read_mask();
    elseif strcmp(typeMask, 'mean')
        [mask, n_mask] = generate_mean_matrix(nMask);
    elseif strcmp(typeMask, 'gaussian')
        sigma = input("Masukkan nilai standar deviasi: ");
        [mask, n_mask] = generate_gaussian_matrix(nMask, sigma);
    else
        fprintf("Invalid mask type!\n");
        return;
    end
    
    pixel_border = floor(n_mask/2);   
    sum_mask = sum(mask(:));

    % Img details
    fprintf("[INFO] An image size [%d, %d] is inputted!\n", row, col);
    
    % Create placeholder for new image
    if (num_channels == 1 || is_grayscaled)
        fprintf("[PROCESS] Processing grayscale image!\n");
        if (num_channels ~= 1)
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
    checkpoint = 0;
    batch_percentage = 10;
    for r=1:row
        for c=1:col
            if (is_gray)
                % For border
                % If pixel is in border, set it to black (0)
                if (is_border_pixel(img, r, c, pixel_border))
                    result_img(r, c) = 0;  % Set to black
                else
                    local_mat = get_local_mat(img, r, c, n_mask);
                    conv_result = validate_pixel(round(dot_product(local_mat, mask) / sum_mask));
                    result_img(r,c) = conv_result;
                end
            else % For colored image
                red_channel = img(:, :, 1);   % Red channel
                green_channel = img(:, :, 2); % Green channel
                blue_channel = img(:, :, 3);  % Blue channel

                % If pixel is in border, set it to black (0)
                if (is_border_pixel(img, r, c, pixel_border))
                    result_img(r, c, 1) = 0; % Black for red channel
                    result_img(r, c, 2) = 0; % Black for green channel
                    result_img(r, c, 3) = 0; % Black for blue channel
                else
                    local_mat_red = get_local_mat(red_channel, r, c, n_mask);
                    conv_result_red = validate_pixel(round(dot_product(local_mat_red, mask) / sum_mask));
                    result_img(r, c, 1) = conv_result_red;

                    local_mat_green = get_local_mat(green_channel, r, c, n_mask);
                    conv_result_green = validate_pixel(round(dot_product(local_mat_green, mask) / sum_mask));
                    result_img(r, c, 2) = conv_result_green;

                    local_mat_blue = get_local_mat(blue_channel, r, c, n_mask);
                    conv_result_blue = validate_pixel(round(dot_product(local_mat_blue, mask) / sum_mask));
                    result_img(r, c, 3) = conv_result_blue;
                end
            end
        end
        if (mod(r, round(row / batch_percentage)) == 0)
           checkpoint = checkpoint + (100 / batch_percentage);
           fprintf("[CHECKPOINT] Checkpoint of Convolution process: %d%%\n", checkpoint);
        end
    end
    disp("[FINISHED] Finish processing!");
end