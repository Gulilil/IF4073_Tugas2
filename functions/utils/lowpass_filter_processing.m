function meshArrays = lowpass_filter_processing(frequencyType, P, Q, cutoffFrequency)
    % Designing filter 
    u = 0:(P-1); 
    idx = find(u > P/2); 
    u(idx) = u(idx)-P; 
    v = 0:(Q-1); 
    idy = find(v > Q/2); 
    v(idy) = v(idy)-Q; 
    
    % Create meshgrid for computing distance from center
    [V, U] = meshgrid(v, u);
    euclidean = sqrt(U.^2 + V.^2); % Euclidean distance from center

    frequencyType

    % Set mesh arrays based on the condition of frequency type
    if strcmp(frequencyType, "ILPF")
        meshArrays = double(euclidean <= cutoffFrequency); % Ideal Lowpass Filter mask (1 inside cutoff, 0 outside)
    elseif strcmp(frequencyType, "GLPF")
        meshArrays = exp(-(euclidean.^2) ./ (2 * (cutoffFrequency^2))); % Gaussian Lowpass Filter mask
    elseif strcmp(frequencyType, "BLPF")
        n = 2; % Order of Butterworth filter
        meshArrays = 1 ./ (1 + (euclidean ./ cutoffFrequency).^(2 * n)); % Butterworth Lowpass Filter mask
    else
        fprintf("Invalid frequency type\n");
    end

    meshArrays = fftshift(meshArrays); % Shift filter to center the low-frequency components