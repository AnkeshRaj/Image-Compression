function [I] = Smoothing_dwt(I,l)
for i=1:l
n = 5;                   
w = 'sym8';              
[c l] = wavedec2(I,n,w); 
opt = 'gbl'; 
thr = 20;    
sorh = 's';  
keepapp = 1;
[xd,cxd,lxd,perf0,perfl2] = wdencmp(opt,c,l,w,n,thr,sorh,keepapp);
I=uint8(xd);
end
end

