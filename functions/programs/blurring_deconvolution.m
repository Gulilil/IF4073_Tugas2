function image_blurred = blurring_deconvolution(img, len, theta)
    % Menjalankan fungsi Motion Blurring
    [blur_processing, image_blurred] = motion_blur(img, len, theta);

    % Menampilkan gambar original and motion-blurred
    subplot(2, 3, 1); imshow(img); title("Original Image");
    subplot(2, 3, 2); imshow(image_blurred); title("Motion Blur Image");
    
    % Menjalankan fungsi untuk Deblurring dengan penapis Weiner
    noise_var = 0.0001;
    wiener_result = wiener_deconvolution_scratch(img, noise_var, blur_processing, image_blurred);
    
    % Menampilkan gambar yang sudah diperbaiki secara Scratch
    subplot(2, 3, 3); imshow(wiener_result); title("Restored Image (Scratch)");

    % Konversi image ke dalam bentuk double
    img_converted = im2double(img);
    
    % Menghitung perbedaan absolut antara gambar original dengan gambar yang diperbaiki
    subplot(2, 3, 6); imshow(imabsdiff(img_converted, wiener_result)); title('Original VS Restored Image (Scratch)');
end