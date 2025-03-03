function [S, U1, U2, U3] = hosvd (T)
    [U1, ~, ~]=svd(unfold(T,1), 'econ');
    [U2, ~, ~]=svd(unfold(T,2), 'econ');
    [U3, ~, ~]=svd(unfold(T,3), 'econ');
    S=mnozenje(mnozenje(mnozenje(T, U1', 1), U2', 2), U3', 3);
    pom=mnozenje(mnozenje(mnozenje(S, U1, 1), U2, 2), U3, 3);
end