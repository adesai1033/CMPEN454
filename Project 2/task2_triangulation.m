function [ssd, recoveredPoints] = task2_triangulation(pixels1, pixels2, Rmat1, Rmat2, Pmat1, Pmat2, Kmat1, Kmat2, pts3D)
% Want to recover 3D point of the corresponding point pairs from both cameras
%Can recover viewing ray of both cameras, but they will not intersect due
%to noise
%Estimate intersection by finding closest point between two rays
%Closest point will lie on the line orthogonal to both rays
%Compute the crossproduct of both rays, find midpoint
recoveredPoints = zeros(3, 39);
T1 = -1 .* Pmat1(:, 4);
T2 = -1 .* Pmat2(:, 4);

c1Loc = Rmat1' * T1;
c2Loc = Rmat2' * T2;

%CHECK LATER FOR HOMOGENEOUS COORDINATES SOME SHOULD NOT BE HOMO
numCols = size(pixels1, 2);
for col = 1:numCols;

    currPointCam1 = pixels1(:, col);  %Corresponding columns are corresponding pixels
    currPointCam2 = pixels2(:, col);

    v1 = Rmat1' * Kmat1^(-1) * currPointCam1; %Computes and normalizes the viewing vector of camera 1
    v1 = v1/norm(v1);                         

    v2 = Rmat2' * Kmat2^(-1) * currPointCam2; %Computes and normalizesviewing vector of camera 2
    v2 = v2/norm(v2);                        

    v3 = cross(v1, v2); %Compute the vector orthogonal to both rays b/c closest point will be on this line
    v3 = v3/norm(v3);
    %au1 + du3 - bu2 = c2-c1
    matrix = [v1, v3, -v2];
    solution = linsolve(matrix, c2Loc - c1Loc); %Solve system of equations
    p1 = c1Loc + solution(1)*v1;
    p2 = c2Loc + solution(3)*v2;
    recoveredPoints(:, col) = 1/2 * (p1 + p2); %Halfway point

    diffSquared = (recoveredPoints - pts3D).^2;
    
    % Sum all the elements of the squared difference matrix
ssd = sum(diffSquared(:));

end