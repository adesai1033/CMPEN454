function [corners,cornersFound] = corner_extraction(rScores, numCorners,surpressRad, img)
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
cornersFound =  numCorners;
corners = zeros(numCorners,3);
[numRows, numCols] = size(rScores);
for i=1:numCorners;
    [maxval, idx] = max(rScores(:)) %flatten R so we can extract max and its idx (not actually changing R)
    if maxval < 0;
        break
    end
    [y,x] = ind2sub(size(rScores),idx); %get x,y coord from 1d coord
    corners(i, :) = [x,y,maxval];
    rScores(y,x) = 0
    y_min = max(1, y - surpressRad);
    x_min = max(1, x - surpressRad);
    
    y_max = min(numRows, y + surpressRad);
    x_max = min (numCols, x + surpressRad);

     rScores(y_min:y_max, x_min:x_max) = 0;
end
imshow(img);
hold on
for i = 1:size(corners, 1)
    x = corners(i, 1);
    y = corners(i, 2);
    rectangle('Position', [x, y,7,7], 'EdgeColor', 'red', 'LineWidth', 2);
end
hold off


