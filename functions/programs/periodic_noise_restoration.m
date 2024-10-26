function [result_img, fourierDisplay, meshArrays] = periodic_noise_restoration(img, filter_type)

[M, N, n_channel] = size(img);
title('original image');

% Lakukan transformasi Fourier pada f(x, y)
% Display the Fourier Spectrum
[fourierSpectrum, fourierDisplay] = fourier_transform(M, N, n_channel, img);

meshArrays = filter_processing(filter_type, M, N, 0, 0, 0, 0); % Ignore cutoff Frequency, n, gammaL, and gammaH
result_img = img;
end