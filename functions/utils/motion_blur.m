function image_restored = motion_blur(img)
    len = input("Masukkan nilai len untuk Motion Blur: ");
    theta = input("Masukkan nilai theta untuk Motion Blur: ");

    blur_processing = fspecial('motion', len, theta);   
    image_restored = imfilter(img, blur_processing, 'replicate');