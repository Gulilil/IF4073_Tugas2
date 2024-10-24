function image_restored = blurring_deconvolution(img)
    % Menjalankan fungsi untuk Motion Blurring
    image_restored = motion_blur(img);

    % % Menampilkan gambar sebelum dan sesudah Motion Bluring
    % subplot(1, 2, 1); imshow(img); title("Original Image");
    % subplot(1, 2, 2); imshow(image_restored); title("Motion Blur Image");
