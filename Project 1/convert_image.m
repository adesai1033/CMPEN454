%Convert image to grey scale, smooth by sigma facter sig
function imageTransform = convert_image(image_filename, sig)
    image = imread(image_filename);
    grayscaleImage = rgb2gray(image);
    doubleImage = im2double(grayscaleImage); 
    %imageTransform = imgaussfilt(doubleImage,sig); 
    halfwid = 3*sig;
    [xx,yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);
    gau = 1/(2*pi*sig)* (exp(-1/(2*sig^2) * (xx.^2 + yy.^2)))
    imageTransform = conv2(doubleImage,gau,'same')
    imshow(imageTransform);
end