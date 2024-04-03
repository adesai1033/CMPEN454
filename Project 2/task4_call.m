%load('Parameters_V1.mat');
%c1Center = Parameters.position
%load('Parameters_V2.mat');
%c2Center = Parameters.position
Fmat_known = task4_fundamental_matrix(Rmat1, Rmat2, Kmat1, Kmat2, Pmat1, Pmat2, im1, im2, pixels1, pixels2);