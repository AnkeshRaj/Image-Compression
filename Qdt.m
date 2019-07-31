function [data,outim] = Qdt(I,Th,MIN,MAX)

s=qtdecomp(I,Th,[MIN MAX]);
[i,j,blksz] = find(s);
blkcount=length(i);  
avg=1;%=zeros(blkcount,1);
i2=1;%=zeros(blkcount,1);
j2=1;%=zeros(blkcount,1);
blk2=2;%=zeros(blkcount,1);
count=1;
mn=0;
for k=1:blkcount 
    mat=I(i(k):i(k)+blksz(k)-1,j(k):j(k)+blksz(k)-1);
    mn=round(median(mat(:)));
    if mn~=0
        i2(count)=i(k);
        j2(count)=j(k);
        avg(count)=mn;
        blk2(count)=blksz(k);
        count=count+1;
    end
end
i2(end+1)=0;j2(end+1)=0;blk2(end+1)=0;
data=[i2 j2 blk2 avg];
datanew=data;
zeroindx=find(data==0);%find boundries
inew=datanew(1:zeroindx(1)-1); %seperate row index
jnew=datanew(zeroindx(1)+1:zeroindx(2)-1); %seperate column index
blksznew=datanew(zeroindx(2)+1:zeroindx(3)-1);%seperate blocksize
avgnew=datanew(zeroindx(3)+1:end);
avgnew=double(avgnew);
outim=zeros(size(I));
blkcount=length(inew);
for k=1:blkcount 
  outim(inew(k):inew(k)+blksznew(k)-1,jnew(k):jnew(k)+blksznew(k)-1)=avgnew(k);
end

data=[i2 j2 avg];
end


% [x,y]=size(I);
% i2=1;%=zeros(blkcount,1);
% j2=1;%=zeros(blkcount,1);
% blk2=2;%=zeros(blkcount,1);
% k=1;
% for i=1:x
%     for j=1:y
%         if I(x,y)~=0
%             i2(k)=i;
%             j2(k)=j;
%             blk2(k)=I(i,j);
%             k=k+1;
%         end
%     end
% end
% data=[i2 j2 blk2];
% outim=I;
%shift by min(min((I));
% datanew = huffmandeco(comp,dict);% decode the data.
% zeroindx=find(data==0);%find boundries
% img=zeros(r,c); 
% for l=2:length(zeroindx)
%     for k=1:3:blkcount(l)/3 
%   outim(inew(k):inew(k)+blksznew(k)-1,jnew(k):jnew(k)+blksznew(k)-1)=avgnew(k);
% end
% end