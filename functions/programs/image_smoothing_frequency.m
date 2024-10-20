function image_result =  image_smoothing_frequency(img, frequencyType, cutoffFrequency)
    img = im2double(img); % Convert to double
    [M, N, numChannels] = size(img); % Get the size and number of channels of the original image
    
    figure;
    if numChannels == 1
        % Grayscale image
        subplot(2, 3, 1); imshow(img); title('Original Grayscale Image');
    else
        % RGB image
        subplot(2, 3, 1); imshow(img); title('Original RGB Image');
    end
    
    % Step 1: Define padding parameters (P = 2M and Q = 2N)
    P = 2 * M;
    Q = 2 * N;
    
    % Initialize the padded image
    if numChannels == 1
        % For grayscale images
        pad = padarray(img, [M N], 0, 'post');
    else
        % For RGB images, pad each channel separately
        pad = zeros(P, Q, 3);
        for c = 1:3
            pad(:,:,c) = padarray(img(:,:,c), [M N], 0, 'post');
        end
    end
    
    % Display the padded image
    % subplot(2, 3, 2); imshow(fp); title('Padded Image');
    
    % Step 2: Perform the Fourier Transform on the padded image
    [fourierSpectrum, fourierDisplay] = fourier_transform(P, Q, numChannels, pad);
    
    % Display the Fourier Spectrum
    subplot(2, 3, 3); imshow(fourierDisplay, []); title('Fourier Spectrum');
    
    % Step 3: Create an Filter based on condition
    meshArrays = filter_processing(frequencyType, P, Q, cutoffFrequency);
    
    % Display the Filter
    subplot(2, 3, 4); imshow(meshArrays, []); 
    if frequencyType == "ILPF"
        title('Ideal Lowpass Filter Mask');
    elseif frequencyType == "GLPF"
        title('Gaussian Lowpass Filter Mask');
    elseif frequencyType == "BLPF"
        title('Butterworth Lowpass Filter Mask');
    elseif frequencyType == "IHPF"
        title('Ideal Highpass Filter Mask');
    elseif frequencyType == "GHPF"
        title('Gaussian Highpass Filter Mask');
    elseif frequencyType == "BHPF"
        title('Butterworth Highpass Filter Mask');
    end

    subplot(2, 3, 5); mesh(meshArrays); 
    if frequencyType == "ILPF"
        title('3D View of ILPF Mask');
    elseif frequencyType == "GLPF"
        title('3D View of GLPF Mask');
    elseif frequencyType == "BLPF"
        title('3D View of BLPF Mask');
    elseif frequencyType == "IHPF"
        title('3D View of IHPF Mask');
    elseif frequencyType == "GHPF"
        title('3D View of GHPF Mask');
    elseif frequencyType == "BHPF"
        title('3D View of BHPF Mask');
    end
    
    % Step 4: Apply the filter to the Fourier-transformed image
    if numChannels == 1
        % Apply the filter to grayscale image
        convResult = meshArrays .* fourierSpectrum;
    else
        % Apply the filter to each channel of RGB image
        convResult = zeros(P, Q, 3);
        for c = 1:3
            convResult(:,:,c) = meshArrays .* fourierSpectrum(:,:,c);
        end
    end
    
    % Step 5: Perform the inverse Fourier Transform to get the filtered image
    if numChannels == 1
        fft_result = ifftshift(convResult);
        image_result = real(ifft2(fft_result)); % Inverse FFT for grayscale image
    else
        fft_result = zeros(P, Q, 3);
        image_result = zeros(P, Q, 3);
        for c = 1:3
            fft_result(:,:,c) = ifftshift(convResult(:,:,c));
            image_result(:,:,c) = real(ifft2(fft_result(:,:,c))); % Inverse FFT for each channel of RGB image
        end
    end
    
    % Display the Filtered Image (with padding)
    % subplot(2, 3, 5); imshow(G2, []); title('Filtered Image (with padding)');
    
    % Step 6: Crop the image to its original size
    if numChannels == 1
        % Crop for grayscale image
        image_result = image_result(1:M, 1:N);
    else
        % Crop each channel of RGB image
        image_result = image_result(1:M, 1:N, :);
    end
    
    % Display the Final Output Image (Cropped to Original Size)
    subplot(2, 3, 6); imshow(image_result, []); title('Final Output Image');