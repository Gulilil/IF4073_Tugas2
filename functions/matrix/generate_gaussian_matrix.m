function [mask_mat, n] = generate_gaussian_matrix(nMask, sigma)
    % Generate an n x n Gaussian matrix (kernel) with standard deviation sigma
    % sigma: standard deviation for the Gaussian function

    % Set the value of n to nMask
    n = nMask;
    
    % Create a grid of (x, y) coordinates centered at (0, 0)
    half_size = (nMask - 1) / 2;
    [x, y] = meshgrid(-half_size:half_size, -half_size:half_size);
    
    % Gaussian function
    mask_mat = (1 / (2 * pi * sigma^2)) * exp(-(x.^2 + y.^2) / (2 * sigma^2));
    
    % Normalize the matrix so that the sum of all elements equals 1
    mask_mat = mask_mat / sum(mask_mat(:));
end