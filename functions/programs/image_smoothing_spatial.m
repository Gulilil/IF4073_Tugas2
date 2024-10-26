function imgMeanFiltered = image_smoothing_spatial(img, spatialType, nMask, sigma)
    % spatialType = ["Mean", "Gaussian"]
    % Function to apply mean filter smoothing to an image with added noise

    % Masukkan jumlah nilai untuk pembentukan ukuran matriks mean
    if mod(nMask, 2) == 0
        fprintf("[FAILED] Cannot process even number of n\n");
    else 

        % Proses untuk Image Smoothing dengan Spatial Type yang dipilih
        fprintf("[PROCESS] Image Smoothing using " + spatialType + " Filter\n");
        
        % Apply Mean filter using convolution
        if spatialType == "Mean"
            mask = generate_mean_matrix(nMask);
        elseif spatialType == "Gaussian"
            mask = generate_gaussian_matrix(nMask, sigma);
        end

        imgMeanFiltered = convolution(double(imgWithNoise), mask, nMask);
    end
end