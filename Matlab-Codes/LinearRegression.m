clc
clear all
x = 1:0.1:2;
y = x.^2.*sin(x);
n = length(x);
A = [ones(1,n); x];
y = y(:);
heSo = (A*A')\(A*y);
disp('He so cua ham thuc nghiem y = b + ax la:');
disp(heSo)
hold on
plot(x, y);
plot(x, heSo(1) + heSo(2)*x);
legend('y = x^2*sin(x)', 'y = b + ax');