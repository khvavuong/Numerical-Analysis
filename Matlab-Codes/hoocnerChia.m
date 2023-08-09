function [q, r] = hoocnerChia(x,c)
n=length(x);
q=zeros(1,n);
q(1)=x(1);
for i = 2:n
    q(i)=c*q(i-1)+x(i);
end
r = q(end);
q(end)=[];
end