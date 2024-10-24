function image_restored = motion_blur(img, len, theta)
    blur_processing = fspecial('motion', len, theta);   
    image_restored = imfilter(img, blur_processing, 'replicate');