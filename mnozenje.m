function [umnozak] = mnozenje (T, A, mod)
    t=unfold(T, mod);
    M=A*t;
    [i, j, k]=size(T);
    [m,n]=size(A);
    if mod==1
        umnozak=fold(M, m,j,k, mod);
    end
    if mod==2
        umnozak=fold(M, i,m,k, mod);
    end    
    if mod==3
        umnozak=fold(M, i,j,m, mod);
    end
end

