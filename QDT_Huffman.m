function [outim,dict,comp, bits_in_final] = QDT_Huffman( I,Th,MIN,MAX)
%% 1.input Image
output=I;
output=output-min(min(output));
output=round(output);
s=qtdecomp(output,Th,[MIN MAX]);%divides image using quadtree decomposition of threshold .2 and min dim =2 ,max dim =64
[i,j,blksz] = find(s);
blkcount=length(i);  
avg=zeros(blkcount,1);
for k=1:blkcount 
    avg(k)=median(median(output(i(k):i(k)+blksz(k)-1,j(k):j(k)+blksz(k)-1)));                                                               %value
end 
avg=round(avg);%????????????????????????????
figure,imshow((full(s)));title('Quadtree Decomposition');drawnow;
%% 3.Huffman Encoding

i(end+1)=0;j(end+1)=0;blksz(end+1)=0;
data=[i;j;blksz;avg];
data=single(data); 
symbols= unique(data);
counts = hist(data(:), symbols);
p = counts./ sum(counts);
sp=round(p*1000);
dict = huffmandict(symbols,p');
comp = huffmanenco(data,dict);
%% 4.Compressed
%compression data suze
bits_in_final=length(comp)+8*length(symbols)+8*length(sp);

%% 5.Huffman Decoding
datanew = huffmandeco(comp,dict);% decode the data.
zeroindx=find(data==0);%find boundries
inew=datanew(1:zeroindx(1)-1); %seperate row index
jnew=datanew(zeroindx(1)+1:zeroindx(2)-1); %seperate column index
blksznew=datanew(zeroindx(2)+1:zeroindx(3)-1);%seperate blocksize
avgnew=datanew(zeroindx(3)+1:end); %seperate mean values
%% 6.Decompressed image
avgnew=double(avgnew);
for k=1:blkcount 
  outim(inew(k):inew(k)+blksznew(k)-1,jnew(k):jnew(k)+blksznew(k)-1)=avgnew(k);
end
outim=double(outim);
outim=outim+min(min(I));
figure,
imagesc(outim)
colormap gray
title('Decompressed Image from Quadtree')