function [A1, S, Sinv] = Goi2(A, k)
%k la vi tri dong cần thuc hien dua ve dang chuan Frobenius
%ham nay dua dong thu k cua ma tran ve dang [0 0 .. 1 .. 0]
%so 1 o vi tri thu k
    n = size(A,1);
    S = eye(n);
    S(k-1,:) = A(k,:);
    Sinv = eye(n);
    Sinv(k-1,:) = -A(k,:)./A(k,k-1);
    Sinv(k-1,k-1) = 1/A(k,k-1);
    A1 = S*A*Sinv;

end