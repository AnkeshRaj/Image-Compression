clc
clear 
close all
P=imread('lena.bmp');
im=P;
[r,c]=size(P);              % r-No. of rows, c-No. of columns
subplot(221)
imshow(P)
title('Original Image')
subplot(222)
imhist(P)
title('Original Histogram')
P=double(reshape(P,1,r*c)); % Reshaped in 1 row because lwt takes 1-D input 
LS = liftwave('haar','int2int');
[CA,CD] = lwt(P,LS);        % Both the outputs having size=r*c/2 (half the 
CD=reshape(CD,1,r*c/2);
C=ilwt(CA,CD,LS);
C=reshape(C,r,c);
subplot(223)
imshow(uint8(C))

