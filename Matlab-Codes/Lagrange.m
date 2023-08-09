function L = Lagrange(x, y)
% x la vecto chua cac moc noi suy
% y la vecto chua gia tri tuong ung tai cac moc noi suy
n = length(x);
L = zeros(1, n);
for j = 1:n
    S = 1;
    for i = 1:n
        if i~=j
            S = conv(S, [1 -x(i)]./(x(j)-x(i)));
            length(S)
        end
    end
    L = L + y(j)*S;
end