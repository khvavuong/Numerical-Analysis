function p = Legendre(n)
syms x;
p0=1; p1=x; p2=(3*x^2-1)/2;
for k=2:(n-1) 
    p3=(2*k+1)/(k+1)*x*p2-k/(k+1)*p1;
    p1=p2;
    p2=p3;
end
p = sym2poly(p3);
end
