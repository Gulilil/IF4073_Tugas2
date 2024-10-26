function [result_img, meshArrays] = periodic_noise_restoration(img, filter_type, W, D0, D1)

[M, N, n_channel] = size(img);

% Process Fourier
[fourierSpectrum, ~] = fourier_transform(M, N, n_channel, img);

if filter_type == "Bandreject"  
    % Set up range of variables.
    u = 0:(M-1);
    v = 0:(N-1);
    % Compute the indices for use in meshgrid
    idx = find(u > M/2);
    u(idx) = u(idx) - M;
    idy = find(v > N/2);
    v(idy) = v(idy) - N;
    % Compute the meshgrid arrays
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2);
    n = 1; 
    H = 1./(1 + ((D*W)./(D.^2 - D0^2)).^(2*n));
    meshArrays = fftshift(H);

elseif filter_type == "Bandpass"
    nx = M;
    ny = N;

    f = uint8(img);
    fftI = fft2(f,2*nx-1,2*ny-1);
    fftI = fftshift(fftI);

    % Initialize filter.
    filter1 = ones(2*nx-1,2*ny-1);
    filter2 = ones(2*nx-1,2*ny-1);
    filter3 = ones(2*nx-1,2*ny-1);

    for i = 1:2*nx-1
        for j =1:2*ny-1
            dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
            % Use Gaussian filter.
            filter1(i,j) = exp(-dist^2/(2*D1^2));
            filter2(i,j) = exp(-dist^2/(2*D0^2));
            filter3(i,j) = 1.0 - filter2(i,j);
            filter3(i,j) = filter1(i,j).*filter3(i,j);
        end
    end
    % Update image with passed frequencies
    filtered_image = fftI + filter3.* fftI;
    filtered_image = ifftshift(filtered_image);
    filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
    filtered_image = real(filtered_image(1:nx,1:ny));
    result_img = uint8(filtered_image);
    meshArrays = filter3;

else% filter_type == "Notch"

    notch_centers = [M/2 + 30, N/2 + 40; M/2 - 30, N/2 - 40]; 

    % Initialize the notch filter with ones
    H = ones(M, N);
    
    % Create a notch filter around each noise location
    [x, y] = meshgrid(1:N, 1:M);
    for i = 1:size(notch_centers, 1)
        notch_center = notch_centers(i, :);
        D = sqrt((x - notch_center(2)).^2 + (y - notch_center(1)).^2);
        H(D <= D0) = 0; % Set the values within the radius to zero
    end
    meshArrays = H;
end


if (filter_type == "Bandreject" || filter_type == "Notch")
    if n_channel == 1
        % Menerapkan filter pada grayscale image
        f_transformed = meshArrays .* fourierSpectrum;
    else
        % Menerapkan filter pada setiap channel warna dari gambar RGB
        f_transformed = zeros(M, N, 3);
        for c = 1:3
            f_transformed(:,:,c) = meshArrays .* fourierSpectrum(:,:,c);
        end
    end
    
    if n_channel == 1
        fft_result = ifftshift(f_transformed);
        result_img = real(ifft2(fft_result)); % Inverse FFT untuk gambar grayscale
    else
        fft_result = zeros(M, N, 3);
        result_img = zeros(M, N, 3);
        for c = 1:3
            fft_result(:,:,c) = ifftshift(f_transformed(:,:,c));
            result_img(:,:,c) = real(ifft2(fft_result(:,:,c))); % Inverse FFT untuk setiap warna channel dari gambar RGB
        end
    end

result_img = rescale(result_img);
disp(result_img(1:10, 1:10));

    
end