x=1:0.2:2.2;
y=[1.5850, 1.6781, 1.7655, 1.8480, 1.9260, 2.0, 2.0704];
n = length(x);
A = diag(-1*ones(1,n)) + diag(ones(1,n-1),1);
z = y;
Heso = zeros(1,n);
Heso(1) = z(1);
for i = 1:n
    z = A*z(:);
   if i<n
       Heso(i+1) = z(1);
   end
   z
end
disp('Sai phan cac cap tai moc y1 la:');
disp(Heso);
p=Heso(end)/factorial(n-1);
for k = n-1:-1:1
    p = [p Heso(k)/factorial(k-1)]-[0 p*(k-1)];
end
disp('He so cua da thuc noi suy Newton tien MCD la:');
disp(p);