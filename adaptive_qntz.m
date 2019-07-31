function [Q,R,L,md,R_final] = adaptive_qntz(cA2)
[x,y]=size(cA2);
CA1=round(cA2);
md=round(median(CA1(:)));
CA1=CA1-md;
Max=abs(max(max(CA1)));
Min=abs(min(min(CA1)));
R=Max/10;
L=Min/10;
Qp=CA1>=0;
Qp=Qp.*CA1;
Qp=Qp/R;

Qn=CA1<0;
Qn=Qn.*CA1;
Qn=Qn/L;

Q=round(Qp+Qn);

Rp=((((Q>0).*Q))*R).*(Q>0);
Rn=((((Q<0).*Q))*L).*(Q<0);
R_final=round(Rp+Rn+md);

end

