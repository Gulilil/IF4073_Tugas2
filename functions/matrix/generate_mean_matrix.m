function [mask_mat, n] = generate_mean_matrix(nMask)
    % Set the value of n to nMask
    n = nMask;
    
    % Create an nMask x nMask matrix filled with ones
    mask_mat = ones(nMask);
    
    % Calculate the total sum of all elements in the matrix (which is nMask^2)
    total_sum = sum(mask_mat(:));
    
    % Divide each element of the matrix by the total sum to get the mean matrix
    mask_mat = mask_mat / total_sum;
end