function [R_final] = De_qntz(Q,R,L,md)

Rp=((((Q>0).*Q))*R).*(Q>0);
Rn=((((Q<0).*Q))*L).*(Q<0);
R_final=round(Rp+Rn+md);

end

