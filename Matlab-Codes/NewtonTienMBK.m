function [p, y, val] = NewtonTienMBK(x, y, u)
n = length(x);
%tinh ty sai phan cac cap chua moc y0
for j = 2:n
    for i = n:-1:j
        y(i) = (y(i)-y(i-1))/(x(i)-x(i-j+1));
    end
end
p = y(end);
% dua da thuc ve dang chinh tac
for j = n-1:-1:1
    p = [p y(j)] - [0 p*x(j)];
end
%tinh gia tri da thuc su dung so do hoocne
val = p(1);
for j = 1:n-1
    val = u.*val + p(j+1);
end