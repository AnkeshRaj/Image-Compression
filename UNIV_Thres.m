function [cv, ch, cd] = UNIV_Thres(cv, ch, cd )

[x,y]=size(cv);
for i=1:2:x-1
    for j=1:2:y-1
        entpy=entropy(ch(i:i+1, j:j+1));
        if  entpy<1%(std2(submatrix)*sqrt(2*log(sum(sum(submatrix>0)))))
           ch(i:i+1,j:j+1)=median(median(ch(i:i+1, j:j+1)));
        end
        entpy=entropy(cv(i:i+1, j:j+1));
        if  entpy<1%(std2(submatrix)*sqrt(2*log(sum(sum(submatrix>0)))))
           cv(i:i+1,j:j+1)=median(median(cv(i:i+1, j:j+1)));
        end
        entpy=entropy(cd(i:i+1, j:j+1));
        if  entpy<1%(std2(submatrix)*sqrt(2*log(sum(sum(submatrix>0)))))
           cd(i:i+1,j:j+1)=median(median(cd(i:i+1, j:j+1)));
        end
    end
end

end

