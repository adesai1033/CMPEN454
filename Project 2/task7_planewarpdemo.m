
%quick and dirty plane warp demo using homographies
%Bob Collins  Nov 2, 2005  Penn State Univ
%

%read source image

source = imread('bldg2.jpg');
%source = imread('bldg4.jpg');
%source = imread('bldg3.jpg');
[nr,nc,nb] = size(source);

%make new image
dest = zeros(nr,nc,nb);

%click four points in source
figure(1); colormap(gray); clf;
imagesc(source);
axis image
%[xpts,ypts] = ginput(4);
xpts = [367.293202764977; 436.046658986175; 485.341589861751; 426.966013824885];
ypts = [354.248847926267; 327.006912442396; 333.493087557604; 365.923963133641];
%input rectangle in destination image
figure(2); colormap(gray); clf;
imagesc(dest);
axis image
%rect = getrect;
xp1 = 7.959101382488385;
yp1 = 3.995391705069039;
xp2 = 5.605812211981569e+02;
yp2 = 3.750046082949309e+02;
xprimes = [xp1 xp2 xp2 xp1]';
yprimes = [yp1 yp1 yp2 yp2]';

%compute homography (from im2 to im1 coord system)
p1 = xpts; p2 = ypts;
p3 = xprimes; p4 = yprimes;
vec1 = ones(size(p1,1),1);
vec0 = zeros(size(p1,1),1);
Amat = [p3 p4 vec1 vec0 vec0 vec0 -p1.*p3 -p1.*p4; vec0 vec0 vec0 p3 p4 vec1 -p2.*p3 -p2.*p4];
bvec = [p1; p2];
h = Amat \ bvec;
fprintf(1,'Homography:');
fprintf(1,' %.2f',h); fprintf(1,'\n');

%warp im1 forward into im2 coord system 
[xx,yy] = meshgrid(1:size(dest,2), 1:size(dest,1));
denom = h(7)*xx + h(8)*yy + 1;
hxintrp = (h(1)*xx + h(2)*yy + h(3)) ./ denom;
hyintrp = (h(4)*xx + h(5)*yy + h(6)) ./ denom;
for b = 1:nb
 dest(:,:,b) = interp2(double(source(:,:,b)),hxintrp,hyintrp,'linear')/255.0;
end

%display result
imagesc(dest);

