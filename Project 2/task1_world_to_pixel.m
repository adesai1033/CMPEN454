function [pixels1, pixels2] = task1_world_to_pixel(Pmat1, Pmat2, Kmat1, Kmat2, pts3D)

% Read world points of mocap data given from data
%Data is a 3x39 matrix where each colum represents the (x, y, z) of a point
pixels1 = zeros(3, 39);
pixels2 = zeros(3, 39);

numCols = size(pts3D, 2);

for col = 1:numCols;
    currPoint = pts3D(:, col); %Read 3D world point (3x1)
    homogeneousPoint = [currPoint; 1]; %Convert to 4x1 homogeneous point

    currPixel1 = Kmat1 * (Pmat1 * homogeneousPoint); %Compute pixel value for both cameras
    currPixel2 = Kmat2 * (Pmat2 * homogeneousPoint); %We know that these are correspondences b/c 
                                                     %they come from same world point
    currPixel1 = currPixel1 ./ currPixel1(3); %Normalize so that homogeneous component = 1
    currPixel2 = currPixel2 ./ currPixel2(3); 

    pixels1(:, col) = currPixel1;  
    pixels2(:, col) = currPixel2;

%PP = Kmat * Pmat * R|T * WP


end