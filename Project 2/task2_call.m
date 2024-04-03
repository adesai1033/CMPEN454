load('Parameters_V1.mat');
Rmat1 = Parameters.Rmat;

load('Parameters_V2.mat');
Rmat2 = Parameters.Rmat;

[ssd, recoveredPoints] = task2_triangulation(pixels1, pixels2, Rmat1, Rmat2, Pmat1, Pmat2, Kmat1, Kmat2, pts3D);