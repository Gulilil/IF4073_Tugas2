addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")
addpath("functions\img\")
addpath("functions\utils\")

% Load the image
img = imread('img_in\camera.bmp');

% Proses Image Smoothing dengan ranah spasial
fprintf("Image Smoothing dengan memanfaatkan ranah frekuensi\n")
fprintf("Pilih jenis ranah frekuensi:\n")
fprintf("1. Low-Pass Filter\n")
fprintf("2. High-Pass Filter\n")
fprintf("\n")
selectedFrequencies = input("Masukkan pilihan (1/2): ");
while selectedFrequencies ~= 1 && selectedFrequencies ~= 2
    fprintf("Pilihan tidak valid\n")
    selectedFilter = input("Masukkan pilihan (1/2): ");
end

if selectedFrequencies == 1
    fprintf("Pilih jenis low-pass filter:\n")
    fprintf("1. Ideal Low-Pass Filter (ILPF)\n")
    fprintf("2. Gaussian Low-Pass Filter (GLPF)\n")
    fprintf("3. Butterworth Low-Pass Filter (BLPF)\n")
    fprintf("\n")
    selectedFilter = input("Masukkan pilihan (1/2/3): ");
    while selectedFilter ~= 1 && selectedFilter ~= 2 &&  selectedFilter ~= 3
        fprintf("Pilihan tidak valid\n")
        selectedFilter = input("Masukkan pilihan (1/2/3): ");
    end
    
    cutoffFrequency = input("Masukkan nilai Cut-Off Frequency: ");
    
    if selectedFilter == 1
        image_smoothing_frequency(img, "ILPF", cutoffFrequency);
    elseif selectedFilter == 2
        image_smoothing_frequency(img, "GLPF", cutoffFrequency);
    elseif selectedFilter == 3
        image_smoothing_frequency(img, "BLPF", cutoffFrequency);
    else
        fprintf("Pilihan tidak valid\n");
    end
elseif selectedFrequencies == 2
    fprintf("Pilih jenis high-pass filter:\n")
    fprintf("1. Ideal High-Pass Filter (IHPF)\n")
    fprintf("2. Gaussian High-Pass Filter (GHPF)\n")
    fprintf("3. Butterworth High-Pass Filter (BHPF)\n")
    fprintf("\n")
    selectedFilter = input("Masukkan pilihan (1/2/3): ");
    while selectedFilter ~= 1 && selectedFilter ~= 2 &&  selectedFilter ~= 3
        fprintf("Pilihan tidak valid\n")
        selectedFilter = input("Masukkan pilihan (1/2/3): ");
    end
    
    cutoffFrequency = input("Masukkan nilai Cut-Off Frequency: ");
    
    if selectedFilter == 1
        image_smoothing_frequency(img, "IHPF", cutoffFrequency);
    elseif selectedFilter == 2
        image_smoothing_frequency(img, "GHPF", cutoffFrequency);
    elseif selectedFilter == 3
        image_smoothing_frequency(img, "BHPF", cutoffFrequency);
    else
        fprintf("Pilihan tidak valid\n");
    end
else
    fprintf("Pilihan tidak valid\n");
end