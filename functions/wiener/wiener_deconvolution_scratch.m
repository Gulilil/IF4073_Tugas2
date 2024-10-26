function wiener_result = wiener_deconvolution_scratch(img, noise_var, blur_processing, image_blurred)
    % Cek apakah gambar Grayscale atau RGB
    if size(img, 3) == 3
        % Inisialisasi hasil dengan ukuran sama seperti input RGB
        wiener_result = zeros(size(img));
        
        % Proses tiap warna terpisah
        for c = 1:3
            img_channel = img(:, :, c);
            image_blurred_channel = image_blurred(:, :, c);
            
            % Apply Wiener deconvolution untuk setiap warna RGB
            wiener_result(:, :, c) = wiener_calculation(img_channel, noise_var, blur_processing, image_blurred_channel);
        end
    else
        % Jika gambar grayscale, langsung proses
        wiener_result = wiener_calculation(img, noise_var, blur_processing, image_blurred);
    end
    
    % Scale gambar ke dalam bentuk gray 0-1
    wiener_result = mat2gray(wiener_result);
end