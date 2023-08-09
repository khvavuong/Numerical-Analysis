n = size(C, 1)
nghiem = zeros(n, 1)
 for k =n:-1:1
        if k == n
            nghiem(n) = C(n,n+1)/C(n,n)
        else
            S = C(k,n+1)- dot(nghiem,C(k,1:n))
            nghiem(k) = S/C(k,k)
        end 
 end
 