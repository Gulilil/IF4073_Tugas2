function [image_result, fourierDisplay, meshArrays] =  image_smoothing_frequency(img, frequencyType, cutoffFrequency, n, gammaL, gammaH)
    % frequencyType = ['ILPF', 'GLPF', 'BLPF', 'IHPF', 'GHPF', 'BHPF', 'Homomorphic']
    addpath('functions\utils');

    img = im2double(img); % Konversi ke double
    [M, N, numChannels] = size(img); % Mencari ukuran dan jumlah channels dalam gambar

    % Step 1: Mendefinisikan padding parameters (P = 2M and Q = 2N)
    P = 2 * M;
    Q = 2 * N;
    
    % Inisialisasi padded image
    if numChannels == 1
        % For grayscale images
        pad = padarray(img, [M N], 0, 'post');
    else
        % Untuk gambar RGB, pad setiap chanel warna secara terpisah
        pad = zeros(P, Q, 3);
        for c = 1:3
            pad(:,:,c) = padarray(img(:,:,c), [M N], 0, 'post');
        end
    end
    
    % Step 2: Menjalankan fungsi Fourier Transform pada padded image
    [fourierSpectrum, fourierDisplay] = fourier_transform(P, Q, numChannels, pad);
    
    % Step 3: Memproses filter frekuensi berdasarkan kondisi pemilihan
    meshArrays = filter_processing(frequencyType, P, Q, cutoffFrequency, n, gammaL, gammaH);
    
    % Step 4: Menerapkan filter pada Fourier-transformed image
    if numChannels == 1
        % Menerapkan filter pada grayscale image
        convResult = meshArrays .* fourierSpectrum;
    else
        % Menerapkan filter pada setiap channel warna dari gambar RGB
        convResult = zeros(P, Q, 3);
        for c = 1:3
            convResult(:,:,c) = meshArrays .* fourierSpectrum(:,:,c);
        end
    end
    
    % Step 5: Menjalankan invers Fourier Transform untuk mendapatkan filtered image
    if numChannels == 1
        fft_result = ifftshift(convResult);
        image_result = real(ifft2(fft_result)); % Inverse FFT untuk gambar grayscale
    else
        fft_result = zeros(P, Q, 3);
        image_result = zeros(P, Q, 3);
        for c = 1:3
            fft_result(:,:,c) = ifftshift(convResult(:,:,c));
            image_result(:,:,c) = real(ifft2(fft_result(:,:,c))); % Inverse FFT untuk setiap warna channel dari gambar RGB
        end
    end
    
    % Step 6: Crop gambar pada ukuran original
    if numChannels == 1
        % Crop for grayscale image
        image_result = image_result(1:M, 1:N);
    else
        % Crop each channel of RGB image
        image_result = image_result(1:M, 1:N, :);
    end