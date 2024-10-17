addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")
addpath("functions\img\")
addpath("functions\utils\")

% Load the image
img = imread('img_in\baboon24.bmp');

% Proses Image Smoothing dengan ranah spasial
fprintf("Image Smoothing dengan memanfaatkan ranah frekuensi\n")
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