function [t, y] = euler(fun, t0, tn, y0, h)
%fun la kieu handle function fun = @(t, y) bieu thuc
t = t0:h:tn; % chu y input sao cho tn = t0+nh
n = length(t);
y = zeros(1, n);
y(1) = y0;
for i = 1:n-1
    y(i+1) = y(i) + h* fun(t(i), y(i));
end
