function [blur_processing, image_blurred] = motion_blur(img, len, theta)
    blur_processing = fspecial('motion', len, theta);   
    image_blurred = imfilter(img, blur_processing, 'conv', "circular");