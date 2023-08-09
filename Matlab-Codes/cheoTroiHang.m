function check = cheoTroiHang(A)
check = 1;
n = size(A, 1);
for row = 1:n
       b = abs(A(row, :));
       tong = sum(b) - b(row);
       if b(row) <= tong
           check = 0;
           return
       end            
end
end