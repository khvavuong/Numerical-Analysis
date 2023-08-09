function [U,Lambda,V] = svdmod(A,tol)
%eigenvector of A'A in V
%eigenvector of AA' in U
%singular values in Lambda
%\example A=[-2  1 1 1;-7 -5 -2 -1;0 -1 -3 -2;-1 0 -1 0] tol = 1e-2
 %example A = [4     2     2; 2     5     1; 2     1     6]   
 if nargin == 1
     tol =  1e-2;
 end
[m, ~]=size(A);
Sigma = eigvalue(A'*A);
r = length(Sigma);
Lambda = diag(Sigma.^(0.5));
V = eigvectors(A'*A, Sigma,tol);
U = zeros(m,r);
for i = 1:r
    U(:,i) = A*V(:,i)/Sigma(i)^(0.5);
end
end