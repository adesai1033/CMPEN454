function [Gx,Gy] = image_gradient(image)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
% Define the kernels for computing the gradients
kernel_gx = [-1/2 0 1/2]; % Kernel for Gx (partial derivatives with respect to x, across rows)
kernel_gy = [-1/2; 0; 1/2]; % Kernel for Gy (partial derivatives with respect to y, down columns)

% Compute Gx by convolving the smoothed image with the kernel_gx
% 'same' ensures the output image is the same size as the input
% Should ensure 1 to 1 correspondence between pixel and gradients
Gx = conv2(image, kernel_gx, 'same');

% Compute Gy by convolving the smoothed image with the kernel_gy
Gy = conv2(image, kernel_gy, 'same');

end