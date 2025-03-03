function [A] = fold (A_mod, i, j, k, mod)
    if mod==1
        A=reshape(A_mod, i,j,k);
    end
    if mod==2
        B=reshape(A_mod, j,i,k);
        for n=1:k
           A(:,:,n)=B(:,:,n)'; 
        end
    end
    if mod==3
        A=reshape(A_mod',i,j,k);
    end
end
