function nghiem = Gaussnghich(B)
%B la ma tran tam giac tren
n = size(B, 1);
nghiem = zeros(n, 1);
 for k =n:-1:1
        if k == n
            nghiem(n) = B(n,n+1)/B(n,n);
        else
            S = B(k,n+1)-sum(nghiem.*B(k,1:n));
            nghiem(k) = S/B(k,k);
        end         
 end