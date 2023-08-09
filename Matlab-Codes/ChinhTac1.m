function omega=ChinhTac1(X)
n=size(X,2);
A=[1 -X(1)];
for i=2:1:n
    A=[A 0]-[0 A].*X(i);
end 
omega=A;
end