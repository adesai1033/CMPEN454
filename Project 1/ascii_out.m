function writeSuccess = ascii_out(cornersExtracted, numFound, img)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
writeSuccess = -1;
filename = 'corners_output.txt';
fileID = fopen(filename, 'w');

if fileID == -1
    error('Failed to open file for writing.');
end

% Write the number of corners to the first line
fprintf(fileID, '%d\n', numFound);
for i=1:numFound
    columnLocation = cornersExtracted(i, 1);
    rowLocation = cornersExtracted(i, 2);
    rValue = cornersExtracted(i, 3);
    
    % Write the current corner's data to the file
    fprintf(fileID, '%f %d %d\n', rValue, columnLocation, rowLocation);
end
writeSuccess = 1;
fclose(fileID);


end
