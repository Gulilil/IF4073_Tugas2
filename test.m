addpath("functions\io\")

read_mask();


img = imread("img_in\lake.jpg"); % ganti disini kalo mau diganti gambarnya
result_img = convolution(img);