function wiener_result_channel = wiener_calculation(img, noise_var, blur_processing, image_blurred)
    % Menjalankan Dekonvolusi dengan Wiener Filter secara Scratch
    % Menjalankan Fourier transform untuk image dan blur kernel
    % Fourier Transform Image (G(u,v))
    img_fft = fft2(double(image_blurred), size(img, 1), size(img, 2));

    % Padding ukuran dari gambar blur kernel
    pad_size = [size(img, 1) - size(blur_processing, 1), size(img, 2) - size(blur_processing, 2)];
    blur_processing_padded = padarray(blur_processing, pad_size, 'post');
    
    % Menjalankan circular shift pada tengah kernel dalam frekuensi domain
    blur_processing_padded = circshift(blur_processing_padded, -floor(size(blur_processing) / 2));

    % Fourier transform dari blur kernel (H(u,v))
    blur_fft = fft2(double(blur_processing_padded), size(img, 1), size(img, 2));
    
    % Wiener filter dalam frekuensi domain
    H_conj = conj(blur_fft);
    H_abs_squared = abs(blur_fft).^2;

    % Formula Wiener filter
    wiener_filter = H_conj ./ (H_abs_squared + noise_var);

    % Menjalankan dekonvolusi dengan Wiener filter
    restored_fft = img_fft .* wiener_filter;
    wiener_result_padded = real(ifft2(restored_fft, size(img, 1), size(img, 2)));

    % Crop padded areas untuk menyamakan dengan ukuran original gambar
    wiener_result_channel = wiener_result_padded(1:size(img, 1), 1:size(img, 2));
    
    % Scale gambar ke dalam bentuk gray 0-1
    wiener_result_channel = mat2gray(wiener_result_channel);
end