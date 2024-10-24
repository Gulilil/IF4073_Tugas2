addpath("functions\io\")
addpath("functions\programs\")
addpath("functions\matrix\")
addpath("functions\img\")

% read_mask();
% 
% img = imread("img_in\butterfly.jpg"); % ganti disini kalo mau diganti gambarnya
% result_img = convolution(img, true);
% 
% img = make_rgb(img);
% result_img = make_rgb(result_img);
% 
% concat_img = cat(2, img, result_img);
% imshow(concat_img);

mask = reshape_mask('1,2,3,4');
haha = display_mat(mask);
disp(haha);