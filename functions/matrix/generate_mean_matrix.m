function [mask_mat, n] = generate_mean_matrix(nMask)
    % Set value dari n to nMask
    n = nMask;
    
    % Membuat nMask x nMask matrix yang terisi dengan angka 1
    mask_mat = ones(nMask);
    
    % Menghitung jumlah total dari semua elemen dalam matrix (nMask^2)
    total_sum = sum(mask_mat(:));
    
    % Membagi setiap elemen dari matrix dengan jumlah total untuk mendapatkan rata-rata matrix
    mask_mat = mask_mat / total_sum;
end