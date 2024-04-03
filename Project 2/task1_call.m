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