function success = harrisImage(rScores)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    success = -1;
    imagesc(rScores);
    colormap('gray');
    success = 1;
end