function rMatrix = harris_r_score(x_grads, y_grads, n)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
GxGx = x_grads .* x_grads;
GyGy = y_grads .* y_grads;
GxGy = x_grads .* y_grads;
neighborFilter = ones(n,n);

Sx2 = conv2(GxGx, neighborFilter, 'same');
Sy2 = conv2(GyGy, neighborFilter, 'same');
Sxy = conv2(GxGy, neighborFilter, 'same');

%Determinant matrix for all (x, y)
detH = Sx2 .* Sy2 - Sxy .^ 2;

%Determinant matrix for all (x, y)
traceH = Sx2 + Sy2;
k = 0.05;
% Calculate the R scores
rMatrix = detH - k * (traceH .^ 2);
end