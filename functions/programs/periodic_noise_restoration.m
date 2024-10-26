function result_img = periodic_noise_restoration(img, filter_type)

imshow(img);
[M, N, n_channel] = size(img);
imshow(img);
title('original image');

% Lakukan transformasi Fourier pada f(x, y)
% Display the Fourier Spectrum
[fourierSpectrum, fourierDisplay] = fourier_transform(M, N, n_channel, img);
figure, imshow(fourierDisplay,[]); title('Fourier spectrum');

meshArrays = filter_processing(frequencyType, M, N, 0, 0, 0, 0); % Ignore cutoff Frequency, n, gammaL, and gammaH

end