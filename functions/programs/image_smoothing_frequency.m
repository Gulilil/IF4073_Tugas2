function [image_result, fourierDisplay, meshArrays] =  image_smoothing_frequency(img, frequencyType, cutoffFrequency, n, gammaL, gammaH)
    % frequencyType = ['ILPF', 'GLPF', 'BLPF', 'IHPF', 'GHPF', 'BHPF', 'Homomorphic']
    addpath('functions\utils');

    img = im2double(img); % Convert to double
    [M, N, numChannels] = size(img); % Get the size and number of channels of the original image

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
    
    % Step 2: Perform the Fourier Transform on the padded image
    [fourierSpectrum, fourierDisplay] = fourier_transform(P, Q, numChannels, pad);
    
    % Step 3: Create an Filter based on condition
    meshArrays = filter_processing(frequencyType, P, Q, cutoffFrequency, n, gammaL, gammaH);
    
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
    
    % Step 6: Crop the image to its original size
    if numChannels == 1
        % Crop for grayscale image
        image_result = image_result(1:M, 1:N);
    else
        % Crop each channel of RGB image
        image_result = image_result(1:M, 1:N, :);
    end
   