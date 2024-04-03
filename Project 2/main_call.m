load('Parameters_V1.mat');
Kmat1 = Parameters.Kmat;
Pmat1 = Parameters.Pmat;

load('Parameters_V2.mat');
Kmat2 = Parameters.Kmat;
Pmat2 = Parameters.Pmat;

load('mocapPoints3D.mat');


[pixels1, pixels2] = task1_world_to_pixel(Pmat1, Pmat2, Kmat1, Kmat2, pts3D);

im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

% visualize 2d points for each image
figure(1); imagesc(im1); axis image; hold on;
for i=1:39
    currPixel = pixels1(:, i);
    plot(currPixel(1), currPixel(2), 'ro');
end
hold off; drawnow;

figure(2); imagesc(im2); axis image; hold on;
for i=1:39
    currPixel = pixels2(:, i);
    plot(currPixel(1), currPixel(2), 'ro');
end
hold off; drawnow;
%End of task1 call

load('Parameters_V1.mat');
Rmat1 = Parameters.Rmat;

load('Parameters_V2.mat');
Rmat2 = Parameters.Rmat;

[ssd, recoveredPoints] = task2_triangulation(pixels1, pixels2, Rmat1, Rmat2, Pmat1, Pmat2, Kmat1, Kmat2, pts3D);
%end of task2 call

[floorNormal, wallUnitNormal, headHeight, doorHeight, tripodPoint] = task3_scene_measurements('im1corrected.jpg', 'im2corrected.jpg', Rmat1, Rmat2, Pmat1, Pmat2, Kmat1, Kmat2, pts3D);
%end of task3 call

Fmat_known = task4_fundamental_matrix(Rmat1, Rmat2, Kmat1, Kmat2, Pmat1, Pmat2, im1, im2, pixels1, pixels2);
%end of task4 call

Fmat_8point = task5_eight_point('im1corrected.jpg', 'im2corrected.jpg');
%end of task5 call

[SED_known_mean,SED_8point_mean] = task6_SED_error(pixels1, pixels2, Fmat_known, Fmat_8point)
%end of task 6 call
