function [A_mod] = unfold (T, mod)
[i, j, k]=size(T);
    if mod==1
        A_mod=T(:, :, 1);
        for n=2:k
            A_mod=horzcat(A_mod, T(:,:,n));
        end
    end

    if mod==2
        A_mod=T(:, :, 1)';
        for n=2:k
            A_mod=horzcat(A_mod, T(:, :, n)');
        end
    end

    if mod==3 
        A_mod=squeeze(T(:, 1, :))';
        for n=2:j
            A_mod=horzcat(A_mod, squeeze(T(:, n, :))');
        end
    end
end