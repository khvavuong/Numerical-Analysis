function [x, y] = rk3(fun, x0, X, y0, h)
% fun = @(x,y)expresion
x = x0:h:X;
y = zeros(size(x));
y(1) = y0;
for i = 1:length(x)-1
    k1 = h*fun(x(i), y(i));
    k2 = h*fun(x(i)+h/2, y(i)+k1/2);
    k3 = h*fun(x(i+1), y(i)-k1+2*k2);
    y(i+1) = y(i) +1/6*(k1+4*k2+k3);
end
end