function [A1, S, Sinv, eigValue] = Goi4(A)
%dua vao ma tran co khoi Frobenius duoc tách riêng
%tra ra vecto chua gia tri rieng, ma tran chuyen co so
%dua ma tran goc tren ben phai ve 0
%chua lam duoc truong hop cot cuoi B khac 0
n = size(A,1);
k = n-1;

while (k>0) && (A(k+1,k) ~= 0)
    k = k-1;
end

F = A(k+1:end,k+1:end);
A2 = A(1:k,1:k);
B = A(1:k, k+1:end);
Z = zeros(size(B'));
S = eye(n); Sinv = S;
eigValue = Goi1(F);
eigValue = eigValue(:);
for col = 1:size(B,2)-1
    % dua dan cac cot cua B ve zeros
    Bplus = zeros(size(B));
    Bplus(:,col+1) = B(:,col);
    Bminus = - Bplus;
    S1 = [eye(size(A2,1)), Bminus; Z, eye(size(F,1))];
    S = S1*S;
    S1inv = [eye(size(A2,1)), Bplus; Z, eye(size(F,1))];
    Sinv = S*S1inv;
    B= A2*Bplus + B + Bminus*F;
    A1 = [A2, B; Z, F];
end

if all(B(:,end)==0) == false
    %chuyen cot B(:,end) len dau va thuc hien lai
    W = eye(size(F,1)); W = [W(:,end), W]; W(:,end)=[];
    U = [eye(size(A2,1)), Z'; Z, W];
    Uinv = U';
    S = U*S;
    Sinv = Sinv*Uinv;
    F = W*F*W';
    B = B*W';
    A1 = [A2, B; Z F];
 
end

end