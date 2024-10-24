function imgMeanFiltered = image_smoothing_spatial(img, spatialType, nMask, sigma)
    % spatialType = ["Mean", "Gaussian"]
    % Function to apply mean filter smoothing to an image with added noise

    % Masukkan jumlah nilai untuk pembentukan ukuran matriks mean
    if mod(nMask, 2) == 0
        fprintf("[FAILED] Cannot process even number of n\n");
    else 

        % Proses untuk Image Smoothing dengan Spatial Type yang dipilih
        fprintf("[PROCESS] Image Smoothing using " + spatialType + " Filter\n");
        
        % % Add Gaussian noise to the image
        % % Using Image Processing Toolbox
        % imgWithNoise = imnoise(img, 'gaussian', 0.1);

        inputImage = im2double(img);  % Convert to double for noise addition

        % Define noise parameters
        mean = 0;  % Mean of the noise
        variance = 0.01;  % Variance of the noise
        noise = sqrt(variance) * randn(size(inputImage));  % Generate Gaussian noise
        
        % Add noise to the image
        imgWithNoise = inputImage + mean + noise;  % Add mean and noise
        % % Need Image Processing Toolbox
        % imgWithNoise = im2uint8(noisyImage);  % Convert back to uint8 if necessary
        imgWithNoise = min(max(imgWithNoise, 0), 1);
        imgWithNoise = uint8(imgWithNoise * 255);

        
        % Apply Mean filter using convolution
        if spatialType == "Mean"
            mask = generate_mean_matrix(nMask);
        elseif spatialType == "Gaussian"
            mask = generate_gaussian_matrix(nMask, sigma);
        end

        imgMeanFiltered = convolution(double(imgWithNoise), mask, nMask);
    end
end