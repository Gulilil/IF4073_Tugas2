function imgMeanFiltered = image_smoothing_spatial(img, spatialType, nMask)
    % spatialType = ["Mean", "Gaussian"]
    % Function to apply mean filter smoothing to an image with added noise

    % Masukkan jumlah nilai untuk pembentukan ukuran matriks mean
    if mod(nMask, 2) == 0
        fprintf("[FAILED] Cannot process even number of n\n");
    else 

        % Proses untuk Image Smoothing dengan Spatial Type yang dipilih
        fprintf("[PROCESS] Image Smoothing using " + spatialType + " Filter\n");
        
        % Add Gaussian noise to the image
        imgWithNoise = imnoise(img, 'gaussian', 0.1);
        
        % Apply Mean filter using convolution
        if spatialType == "Mean"
            imgMeanFiltered = convolution(double(imgWithNoise), false, "mean", nMask);
        elseif spatialType == "Gaussian"
            imgMeanFiltered = convolution(double(imgWithNoise), false, "gaussian", nMask);
        end
        
        % % Display both images (noisy and filtered) side by side using subplot
        % figure;
        % subplot(1, 2, 1);
        % imshow(imgWithNoise);
        % title('Image with Noise');
        % 
        % subplot(1, 2, 2);
        % imshow(imgMeanFiltered);
        % if spatialType == "Mean"
        %     title('Image after Mean Filter Smoothing');
        % elseif spatialType == "Gaussian"
        %     title('Image after Gaussian Filter Smoothing');
        % end
    end
end