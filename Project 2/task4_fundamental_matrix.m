function Fmat_known = task4_fundamental_matrix(Rmat1, Rmat2, Kmat1, Kmat2, Pmat1, Pmat2, im, im2, pixels1, pixels2)


%Transform cam2 center to be in cam1 coordinate system


cam2Pos = Rmat2' * (-1 .* Pmat2(:, 4));
cam1Pos = Rmat1' * (-1 .* Pmat1(:, 4));

R2to1 = Rmat2 * Rmat1';
T = Rmat1 * (cam2Pos - cam1Pos);%T = Rmat1*cam2Pos;
%T = Rmat1 * (c2Center - c1Center)';%T = Rmat1*cam2Pos;
S = zeros(3,3);
S(2,1) = T(3);
S(3,1) = -T(2);
S(3,2) = T(1);
S(1,2) = -T(3);
S(1,3) = T(2);
S(2,3) = -T(1);

E = R2to1 * S;
%Kmat2 is right and Kmat1 is left
Fmat_known = (Kmat2^(-1))' * E * Kmat1^(-1);

%Image 1 x and y
x1 = pixels1(1, 1:39);
y1 = pixels1(2, 1:39);

%Image 2
x2 = pixels2(1, 1:39);
y2 = pixels2(2, 1:39);


colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%overlay epipolar lines on im2
L = Fmat_known * [x1 ; y1; ones(size(x1))];

[nr,nc,nb] = size(im2);
figure(2); clf; imagesc(im2); axis image;
hold on; plot(x2,y2,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi]);
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


%overlay epipolar lines on im1
L = ([x2 ; y2; ones(size(x2))]' * Fmat_known)' ;
[nr,nc,nb] = size(im);
figure(1); clf; imagesc(im); axis image;
hold on; plot(x1,y1,'*'); hold off
for i=1:length(L)
    a = L(1,i); b = L(2,i); c=L(3,i);
    if (abs(a) > (abs(b)))
       ylo=0; yhi=nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    else
       xlo=0; xhi=nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h=plot([xlo; xhi],[ylo; yhi],'b');
       set(h,'Color',colors(i),'LineWidth',2);
       hold off
       drawnow;
    end
end


for j=1:3
    for i=1:3
        fprintf('%10g ',10000*Fmat_known(j,i));
    end
    fprintf('\n');
end
%}

end