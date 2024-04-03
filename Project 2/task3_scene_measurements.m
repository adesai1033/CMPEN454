function [floorUnitNormal, wallUnitNormal, headHeight, doorHeight, tripodPoint] = task3_scene_measurements(image1, image2, Rmat1, Rmat2, Pmat1, Pmat2, Kmat1, Kmat2, pts3D)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% TASK 3.3 Triangulation to make measurements about the scene
im1 = imread(image1);
im2 = imread(image2);
figure(1); imagesc(im1); axis image; drawnow;
[xpts,ypts] = ginput(9);
figure(2); imagesc(im2); axis image; drawnow;
[xpts2,ypts2] = ginput(9);
c1m = [xpts(1) xpts(2) xpts(3) xpts(4) xpts(5) xpts(6) xpts(7) xpts(8) xpts(9);
   ypts(1) ypts(2) ypts(3) ypts(4) ypts(5) ypts(6) ypts(7) ypts(8) ypts(9);
   1 1 1 1 1 1 1 1 1];
c2m = [xpts2(1) xpts2(2) xpts2(3) xpts2(4) xpts2(5) xpts2(6) xpts2(7) xpts2(8) xpts2(9);
   ypts2(1) ypts2(2) ypts2(3) ypts2(4) ypts2(5) ypts2(6) ypts2(7) ypts2(8) ypts2(9);
   1 1 1 1 1 1 1 1 1];
[~, trigPoints] = task2_triangulation(c1m, c2m, Rmat1, Rmat2, Pmat1, Pmat2, Kmat1, Kmat2, pts3D);
%Find crossproduct
ABf = trigPoints(:, 2) - trigPoints(:, 1);
BCf = trigPoints(:, 3) - trigPoints(:, 2);
ABw = trigPoints(:, 5) - trigPoints(:, 4);
BCw = trigPoints(:, 6) - trigPoints(:, 5);
floorNormal = cross(ABf, BCf);
floorUnitNormal = floorNormal/norm(floorNormal)
wallNormal = cross(ABw, BCw);
wallUnitNormal = wallNormal/norm(wallNormal)
headHeight = trigPoints(3, 7)
doorHeight = trigPoints(3, 8)
tripodPoint = trigPoints(:, 9)
end
