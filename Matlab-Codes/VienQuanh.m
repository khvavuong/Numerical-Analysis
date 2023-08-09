function Ainv = VienQuanh(A)
    a = A([1,2],[1,2]);
    n = size(A,1);
    for i = 3:n
            a = VienQuanh1(A(1:i,1:i),a);
    end
    Ainv = a;
end
function S = VienQuanh1(A, a)
    %A la ma tran can tim nghich dao
    %a la nghich dao cua ma tran (n-1 x n-1)
    n =size(A,1);
    %A1 = A(1:n-1,1:n-1);
    U = A(n,1:n-1);
    V = A(1:n-1,n);
    ann = A(n,n);
    beta12 = a*V*(U*a*V - ann)^(-1);
    beta11 = (eye(n-1) - beta12*U)*a;
    beta22 = (ann -U*a*V)^(-1);
    beta21 = -beta22*U*a;
    S=[beta11, beta12; beta21, beta22];
end