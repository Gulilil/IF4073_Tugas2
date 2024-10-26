function [fourierSpectrum, fourierDisplay] = fourier_transform(P, Q, numChannels, pad)
    % Menjalankan Fourier Transform pada padded image
        if numChannels == 1
            % Fourier Transform untuk gambar grayscale
            fourierSpectrum = fftshift(fft2(pad));
        else
            % Fourier Transform for setiap channel warna pada gambar RGB
            fourierSpectrum = zeros(P, Q, 3);
            for c = 1:3
                fourierSpectrum(:,:,c) = fftshift(fft2(pad(:,:,c)));
            end
        end
        
        % Perhitungan magnitude spectrum untuk display
        if numChannels == 1
            fourierDisplay = log(1 + abs(fourierSpectrum));
        else
            % Untuk gambar RGB, hitung magnitude untuk setiap channel warna dan rata-ratakan
            fourierDisplay = log(1 + abs(fourierSpectrum(:,:,1)) + abs(fourierSpectrum(:,:,2)) + abs(fourierSpectrum(:,:,3))) / 3;
        end