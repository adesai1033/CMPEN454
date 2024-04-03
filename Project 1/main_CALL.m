[filename,S,N,D,M] = read_corner_parameters('cornerparams.dat');
imageTransform = convert_image(filename, S);
[Gx, Gy] = image_gradient(imageTransform);
rMatrix = harris_r_score(Gx, Gy, N);
[corners, cornersFound] = corner_extraction(rMatrix, M, D, imageTransform);
writeSuccess = ascii_out(corners, cornersFound, filename);