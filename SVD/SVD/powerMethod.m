function [lambda, v] = powerMethod(A,tol,M)
if nargin ==1
    tol =1e-10;
    M=200;
end
if nargin ==2
    M=200;
end

%tol là giá tr? ?i?u ch?nh
%M s? l?n l?p nhi?u nh?t cho phép
%example1
%T =[10     9    10;    10     2     8;     5     5    10];
%A= T*diag([11,-11, 2])*inv(T);
%example2
%A=[-2 1 1 1;-7 -5 -2 -1; 0 -1 -3 -2; -1 0 -1 0];
%example3
% A=[2 3 2;4 3 5;3 2 9]
%tol =1e-3;
n = size(A,1);
x = ones(n,1);
m = 1;
check = false;
lambda = [];
v =zeros(n,0);
% truong hop 1 gtr troi
y1 = x;
while check == false && (m <= M)
    y1 = A*y1;
    y2 = A*y1;
    m= m+1;
    check = KTsongsong(y1,y2,tol);
end
if check == true
    lambda = [lambda; mean(y2(y2~=0)./y1(y1~=0))];
   v1 = y1./norm(y1,2);
    v = [v,v1];
    return
end
%truong hop 2 nghiem doi nhau
if check == false
    m = 1;
    y1 = x;
    while check ==false && (m <= M)
        y1 = A*y1;
        y2 = A*y1;
        y3 = A*y2;
       m= m+1;
        check = KTsongsong(y1,y2,tol);
    end
if check == true
    lambda1 = sqrt(mean(y3(y3~=0)./y1(y1~=0)));
    lambda = [lambda;lambda1;-lambda1];
    v1 = y2+lambda1*y1;
    v1 = v1/norm(v1,2);
    v2 = y2-lambda1*y1;
    v2 = v2./norm(v2,2);
    v=[v,v1,v2];
    return
end
end
%truong hop 2 nghiem phuc lien hop
if check == false
     y1 = ((A^(2*m+2))*x);
     y2 = ((A^(2*m))*x);
     y3 = ((A^(2*m+1))*x);
    index = find(y1~=0);
    r = index(1);
    s = index(2);
end
    syms z
    p = det([1, y2(r), y2(s);...
          z, y3(r), y3(s); z^2 y1(r) y1(s)]);
    lambda = double(solve(p,z));
    v1 = y3-lambda(2)*y1;
    v1 = v1/norm(v1,2);
    v2 = y3-lambda(1)*y1;
    v2 = v2/norm(v2,2);
    v= [v1,v2];
end
