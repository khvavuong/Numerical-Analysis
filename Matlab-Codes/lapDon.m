function [X1, saiSo] = lapDon(A, b, X0, k)
n=size(A,1);
if cheoTroiHang(A)==1
    A2 = A - diag(diag(A));
    A2 = -A2;
    T = diag(diag(A).^(-1));
    alpha = T*A2;
    beta = T*b;
    X1=alpha*X0+beta;
    for i = 1:(k-1)
        X0=X1;
        X1=alpha*X0+beta;
    end
    q = norm(alpha, inf);
    saiSo = q/(1-q)*norm(X1-X0,inf);
end
end