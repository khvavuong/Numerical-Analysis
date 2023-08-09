function [eigValue,P, Pinv, A2] = GoiA(A)
% GoiA nhan vao ma tran co khoi Frobenius o goc
% tra ra gia tri rieng cua khoi Frobenius, ma tran o goc
% phep biến đổi tương ứng.
n = size(A,1);
count = n-1;
check = false;
P = eye(n);
Pinv = eye(n);

while check ==  false
    while A(count+1, count) ~= 0 
        [A, S, Sinv] = Goi2(A, count+1);
        P = S*P;
        Pinv = Pinv*Sinv;
        count = count-1;
        if count <1 
            break
        end
    end
    if all(A(count+1,1:count)==0)==false
        [A, S, Sinv] = Goi3(A,count+1);
        P = S*P;
        Pinv = Pinv*Sinv;
    else
        check = true;
        [A, S, Sinv, eigValue] = Goi4(A);
        P = S*P;
        Pinv = Pinv*Sinv;
    end
end
A2 = A(1:count,1:count);
end