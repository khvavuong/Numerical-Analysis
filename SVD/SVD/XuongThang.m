function [A1,theta] = XuongThang(A,v)
%tra ra ma tran A1 da xuong thang
[~,i] = max(abs(v));
v = v/v(i);
n = size(A);
theta = eye(n);
theta(:,i) = theta(:,i) - v;
A1 = theta*A;
end