addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")
addpath("functions\img\")
addpath("functions\utils\")
addpath("functions\wiener\")

% Load the image
fileName = 'img_in\camera.bmp';
img = imread(fileName);

% Membuat Motion Blur pada gambar
fprintf("File yang akan diproses yaitu: %s\n", fileName);
fprintf("Proses Motion Blurring pada gambar...\n");

% Memanggil fungsi untuk Motion Blurring dan Deconvolution
image_restored = blurring_deconvolution(img, 50, 135);