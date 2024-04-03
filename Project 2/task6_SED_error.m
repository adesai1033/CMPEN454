function [SED_known_mean,SED_8point_mean] = task6_SED_error(pixels1, pixels2, Fmat_known, Fmat_8point)

%EpipolarLine_right = F*(point_left)
%EpipolarLine_left = (point_right)^T *(point_left)
%pixels 1 is left pixels2 is right
%Use left points to calculate right epipolar line, then check distance from
%corresponding right point to epipolar line
SED_known = zeros(1, 39);
SED_8point = zeros(1, 39);
numPoints = size(pixels1, 2);

for col = 1:numPoints
    currPoint1 = pixels1(:, col);
    currPoint2 = pixels2(:, col);
    %homogeneousPoint = [currPoint; 1]; %Might need to make homogeneous?
    epipolar_8point = Fmat_8point*currPoint1;  %[a, b, c] st ax + by + c = 0
    epipolar_known = Fmat_known*currPoint1;
    
    distance_known = abs((epipolar_known(1) * currPoint2(1) + epipolar_known(2) * currPoint2(2) + epipolar_known(3))/sqrt(epipolar_known(1)^2 + epipolar_known(2)^2));
    distance_8point = abs((epipolar_8point(1) * currPoint2(1) + epipolar_8point(2) * currPoint2(2) + epipolar_8point(3))/sqrt(epipolar_8point(1)^2 + epipolar_8point(2)^2));
    %find distance from currPoint (x,y,1) and line
    %line ax + by + c = 0
    %point (x0, y0)
    %d = ax0 + by0 + c/(sqrt(a^2 + b^2))
    %test_distance_known = distance_known
    %test_8point = distance_8point
    SED_known(1, col) = distance_known;
    SED_8point(1, col) = distance_8point;


SED_known_mean = mean(SED_known);
SED_8point_mean = mean(SED_8point);
end