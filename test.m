addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")

read_mask();

img = imread("img_in\lake.jpg"); % ganti disini kalo mau diganti gambarnya
imshow(img);
result_img = convolution(img, false);
imshow(result_img);