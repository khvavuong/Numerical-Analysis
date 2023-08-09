function eigVector = Goi1(F)
%nhap vao khoi Frobenius dang 1, tra ra gia tri rieng tương ứng
n = size(F,1);
p = (-1)^(n+1)*[1, -1*F(1,:)];
eigVector = roots(p);
end