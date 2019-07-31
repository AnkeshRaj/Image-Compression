%% clear worksapce
clc
clear all;
close all;
%% Read Image and decompose image

I=imread('lena.bmp');
% I=I(200:200+127,200:200+127); 
els = {'p',[-0.125 0.125],0};
lshaarInt = liftwave('haar','int2int');
lsnewInt = addlift(lshaarInt,els);
[cA1,cH1,cV1,cD1] = lwt2(double(I),lsnewInt);
[cA2,cH2,cV2,cD2] = lwt2(double(cA1),lsnewInt);
[cA3,cH3,cV3,cD3] = lwt2(double(cA2),lsnewInt);
% figure,
% subplot(2,2,1)
% imagesc(cA1)
% colormap gray
% title('Approximation')
% subplot(2,2,2)
% imagesc(cH1)
% colormap gray
% title('Horizontal')
% subplot(2,2,3)
% imagesc(cV1)
% colormap gray
% title('Vertical')
% subplot(2,2,4)
% imagesc(cD1)
% colormap gray
% title('Diagonal')
% 
% figure,
% subplot(2,2,1)
% imagesc(cA2)
% colormap gray
% title('Approximation')
% subplot(2,2,2)
% imagesc(cH2)
% colormap gray
% title('Horizontal')
% subplot(2,2,3)
% imagesc(cV2)
% colormap gray
% title('Vertical')
% subplot(2,2,4)
% imagesc(cD2)
% colormap gray
% title('Diagonal')

[ cV1, cH1, cD1] = UNIV_Thres(cV1, cH1, cD1 );
[ cV2, cH2, cD2] = UNIV_Thres(cV2, cH2, cD2 );
[ cV3, cH3, cD3] = UNIV_Thres(cV3, cH3, cD3 );

cH1=round(cH1);
cV1=round(cV1);
cD1=round(cD1);

cH2=round(cH2);
cV2=round(cV2);
cD2=round(cD2);

cH3=round(cH3);
cV3=round(cV3);
cD3=round(cD3);

[QcV1,R_cV1,L_cV1,md_cV1,R_final_cV1_pre] = adaptive_qntz(cV1);
[QcH1,R_cH1,L_cH1,md_cH1,R_final_cH1_pre] = adaptive_qntz(cH1);
[QcD1,R_cD1,L_cD1,md_cD1,R_final_cD1_pre] = adaptive_qntz(cD1);
[QcV2,R_cV2,L_cV2,md_cV2,R_final_cV2_pre] = adaptive_qntz(cV2);
[QcH2,R_cH2,L_cH2,md_cH2,R_final_cH2_pre] = adaptive_qntz(cH2);
[QcD2,R_cD2,L_cD2,md_cD2,R_final_cD2_pre] = adaptive_qntz(cD2);

[QcV3,R_cV3,L_cV3,md_cV3,R_final_cV3_pre] = adaptive_qntz(cV3);
[QcH3,R_cH3,L_cH3,md_cH3,R_final_cH3_pre] = adaptive_qntz(cH3);
[QcD3,R_cD3,L_cD3,md_cD3,R_final_cD3_pre] = adaptive_qntz(cD3);

 %% DWT Thresholding and Quadt tree compresssion with Huffman ecoding at level 2

 [data_cV1,outim_cV1] = Qdt( QcV1,10,2,32);
 [data_cH1,outim_cH1] = Qdt( QcH1,10,2,32);
 [data_cD1,outim_cD1] = Qdt( QcD1,10,2,32);
 
 [R_final_cV1] = De_qntz(outim_cV1,R_cV1,L_cV1,md_cV1);
 [R_final_cH1] = De_qntz(outim_cH1,R_cH1,L_cH1,md_cH1);
 [R_final_cD1] = De_qntz(outim_cD1,R_cD1,L_cD1,md_cD1);
 
 [data_cV2,outim_cV2] = Qdt( QcV2,10,2,16);
 [data_cH2,outim_cH2] = Qdt( QcH2,10,2,16);
 [data_cD2,outim_cD2] = Qdt( QcD2,10,2,16);

 [R_final_cV2] = De_qntz(outim_cV2,R_cV2,L_cV2,md_cV2);
 [R_final_cH2] = De_qntz(outim_cH2,R_cH2,L_cH2,md_cH2);
 [R_final_cD2] = De_qntz(outim_cD2,R_cD2,L_cD2,md_cD2);
 
 [data_cV3,outim_cV3] = Qdt( QcV3,10,2,16);
 [data_cH3,outim_cH3] = Qdt( QcH3,10,2,16);
 [data_cD3,outim_cD3] = Qdt( QcD3,10,2,16);

 [R_final_cV3] = De_qntz(outim_cV3,R_cV3,L_cV3,md_cV3);
 [R_final_cH3] = De_qntz(outim_cH3,R_cH3,L_cH3,md_cH3);
 [R_final_cD3] = De_qntz(outim_cD3,R_cD3,L_cD3,md_cD3);
%% Thresholding Approximate image of level 2
% cA2=round(cA2);
% [data_cA2,cA2] = Qdt( cA2,2,2,16);
md=median(median(cA3));
Logged=log(cA3+md)/log(md);

integ=floor(Logged);
fract=Logged-integ;

Expo=zeros(size(cA3));
[r,c]=size(cA3);
for i=1:r
    for j=1:c
        Expo(i,j)=md^Logged(i,j);
    end
end
Expo=Expo-md;
Fract=round(fract*10);

%%
data=[Fract(:)',data_cV1,data_cH1,data_cD1,data_cV2,data_cH2,data_cD2,data_cV3,data_cH3,data_cD3];
symbols= unique(data);
counts = hist(data(:), symbols);
p = counts./ sum(counts);
[dict,avglen] = huffmandict(symbols,p',2, 'min');
comp = huffmanenco(data,dict);
bits_in_final=length(comp)+avglen*length(symbols)+8*length(symbols);
%%
% X = idwt2(Expo,R_final_cH2_pre,R_final_cV2_pre,R_final_cD2_pre,'sym4','mode','per');
X = ilwt2(Expo,R_final_cH3,R_final_cV3,R_final_cD3,lsnewInt);
 X1 = ilwt2(X,R_final_cH2,R_final_cV2,R_final_cD2,lsnewInt);
 X2 = ilwt2(X1,R_final_cH1,R_final_cV1,R_final_cD1,lsnewInt);
 X2=uint8(X2);

figure,
subplot(1,2,1)
imagesc(I)
colormap gray
title('Original')
subplot(1,2,2)
imagesc(X2)
colormap gray
title('Final Image')
[x y]=size(I);
disp(8/((y*x*8)/bits_in_final));
disp(psnr(X2,I));
disp(ssim(X2,I));

