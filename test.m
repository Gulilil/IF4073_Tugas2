addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")
addpath("functions\img\")

% read_mask();
% 
img = imread("img_in\lena_noise.jpg"); % ganti disini kalo mau diganti gambarnya

result_img = periodic_noise_restoration(img, "Bandreject");