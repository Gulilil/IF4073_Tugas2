function [image_restored, image_blurred, original_vs_restored] = blurring_deconvolution(img, len, theta, noise_var)
    % Menjalankan fungsi Motion Blurring
    [blur_processing, image_blurred] = motion_blur(img, len, theta);
    
    % Menjalankan fungsi untuk Deblurring dengan penapis Weiner
    image_restored = wiener_deconvolution_scratch(img, noise_var, blur_processing, image_blurred);
    
    % Konversi image ke dalam bentuk double
    img_converted = im2double(img);
    original_vs_restored = imabsdiff(img_converted, image_restored);
end