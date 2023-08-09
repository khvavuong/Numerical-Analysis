syms u
x=0:3;
y=[-5 -6 -1 16];
n = length(x);
L=0;
for j = 1:n
    S=y(j);
    for i = 1:n
        if i~=j
            S = S*(u-x(i))/(x(j)-x(i));       
        end
    end
    L=L+S;
end
fprintf('Da thuc noi suy Lagrange la:\n')
disp(simplify(L))