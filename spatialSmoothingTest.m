addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")
addpath("functions\img\")

img = imread('img_in\butterfly.jpg');

% Proses Image Smoothing dengan ranah spasial
fprintf("Image Smoothing dengan memanfaatkan ranah spasial\n")
fprintf("Pilih jenis filter:\n")
fprintf("1. Mean filter\n")
fprintf("2. Gaussian Filter\n")
fprintf("\n")
selectedFilter = input("Masukkan pilihan (1/2): ");
while selectedFilter ~= 1 && selectedFilter ~= 2
    fprintf("Pilihan tidak valid\n")
    selectedFilter = input("Masukkan pilihan (1/2): ");
end

if selectedFilter == 1
    image_smoothing_spatial(img, "Mean");
elseif selectedFilter == 2
    image_smoothing_spatial(img, "Gaussian");
else
    fprintf("Pilihan tidak valid\n");
end