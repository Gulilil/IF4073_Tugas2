function meshArrays = filter_processing(frequencyType, P, Q, cutoffFrequency)
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
    if frequencyType == "ILPF"
        meshArrays = double(euclidean <= cutoffFrequency); % Ideal Lowpass Filter mask (1 inside cutoff, 0 outside)
    elseif frequencyType == "GLPF"
        meshArrays = exp(-(euclidean.^2) ./ (2 * (cutoffFrequency^2))); % Gaussian Lowpass Filter mask
    elseif frequencyType == "BLPF"
        n = 2; % Order of Butterworth filter
        meshArrays = 1 ./ (1 + (euclidean ./ cutoffFrequency).^(2 * n)); % Butterworth Lowpass Filter mask
    elseif frequencyType == "IHPF"
        meshArrays = double(euclidean > cutoffFrequency); % Ideal Highpass Filter mask (1 outside cutoff, 0 inside)
    elseif frequencyType == "GHPF"
        meshArrays = 1 - exp(-(euclidean.^2) ./ (2 * (cutoffFrequency^2))); % Gaussian Highpass Filter mask
    elseif frequencyType == "BHPF"
        n = 2; % Order of Butterworth filter
        meshArrays = 1 ./ (1 + (cutoffFrequency ./ euclidean).^(2 * n)); % Butterworth Highpass Filter mask
    elseif frequencyType == "Homomorphic"
        gammaL = 2; % Lower gamma value
        gammaH = 4; % Higher gamma value
        meshArrays = (gammaH - gammaL) * (1 - exp(-(euclidean.^2) ./ (2 * (cutoffFrequency^2)))) + gammaL; % Homomorphic Filter mask
    else
        fprintf("Invalid frequency type\n");
    end

    meshArrays = fftshift(meshArrays); % Shift filter to center the frequency components