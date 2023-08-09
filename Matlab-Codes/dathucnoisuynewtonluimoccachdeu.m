function [p, val]=dathucnoisuynewtonluimoccachdeu(x,y,u)
n=length(x);
l=x(2)-x(1);
g=zeros(n,n+1);
z=zeros(1,n);
h=(u-x(end))./l;
for i=1:n
    g(i,1)=x(i);
    g(i,2)=y(i);
end
% dong 7-10 co the thay the: g(:,1)=x(:);
%g(:,2) = y(:);
for i=3:(n+1)%lap theo cac cot
    for j=1:(n-i+2)%lap theo cac dong
        g(j,i)=g(j+1,i-1)-g(j,i-1);
    end
end
for i=2:n+1
    z(i-1)=g(n-i+2,i)/factorial(i-2);% he so cua da thuc noi suy N lui la duong cheo phu chia cho giai thua tuong ung
end

p=z(end);
for i=n-1:-1:1
    p=[p z(i)]- [0 p*(-i+1)];%da thuc lui ta nhan voi don thuc dang (u+i-1)=(u-(-i+1))
end
val=p(1);
for i=1:n-1
    val=h.*val+p(i+1);
end
end