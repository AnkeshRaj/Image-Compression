function [img, bits_in_final] = Huffman(data)


% I=I(61+50:60+50+128,61+50:60+50+128);
[r,c]=size(I);
I=I+1;
% I=I-min(min(I));
temp=zeros(r,c+1);
temp(1:r,1:c)=I;
%
data=reshape(temp.',1,[]);
%
symbols= unique(data);
counts = hist(data(:), symbols);
p = counts./ sum(counts);
sp=round(p*1000);
dict = huffmandict(symbols,p');
comp = huffmanenco(data,dict);
%% 4.Compressed
%compression data suze
bits_in_final=length(comp)+length(dict);

%% 5.Huffman Decoding
datanew = huffmandeco(comp,dict);% decode the data.
zeroindx=find(data==0);%find boundries
img=zeros(r,c);
img(1,1:c)=datanew(1:zeroindx(1)-1);

for i=2:length(zeroindx)
    img(i,1:c)=datanew(zeroindx(i-1)+1:zeroindx(i)-1);
end

figure,
imagesc(img)
colormap gray
title('Decompressed Image from Quadtree')