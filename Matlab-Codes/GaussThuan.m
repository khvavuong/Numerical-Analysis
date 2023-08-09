function B = GaussThuan(A, b)
n = size(A, 1);
B=[A, b];
for k = 1: n-1
    if B(k, k) == 0
        disp('loi chia cho 0')
        return
    else
        for i = k+1:n
            B(i,:) = B(i, :) - B(k, :)*B(i,k)/B(k, k);
        end
    end
end
end