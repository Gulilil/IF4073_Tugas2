function [fourierSpectrum, fourierDisplay] = fourier_transform(P, Q, numChannels, pad)
    % Perform the Fourier Transform on the padded image
        if numChannels == 1
            % Fourier Transform for grayscale image
            fourierSpectrum = fftshift(fft2(pad));
        else
            % Fourier Transform for each color channel in RGB image
            fourierSpectrum = zeros(P, Q, 3);
            for c = 1:3
                fourierSpectrum(:,:,c) = fftshift(fft2(pad(:,:,c)));
            end
        end
        
        % Compute the magnitude spectrum for display
        if numChannels == 1
            fourierDisplay = log(1 + abs(fourierSpectrum));
        else
            % For RGB, take the magnitude for each channel and average them
            fourierDisplay = log(1 + abs(fourierSpectrum(:,:,1)) + abs(fourierSpectrum(:,:,2)) + abs(fourierSpectrum(:,:,3))) / 3;
        end