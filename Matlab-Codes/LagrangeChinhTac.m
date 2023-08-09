function L = LagrangeChinhTac(x, y)
n = length(x);
w = ChinhTac(x);
L = zeros(1,n);
for j =1:n
    thuong = hoocnerChia(w, x(j));
    [~, du] = hoocnerChia(thuong, x(j));
    L=L+thuong*y(j)/du;
end
end