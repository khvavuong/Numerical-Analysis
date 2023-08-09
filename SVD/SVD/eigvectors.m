function V= eigvectors(A,v,tol)
    %example A = [4     2     2; 2     5     1; 2     1     6]   
    if nargin ==2
        tol = 1e-5;
    end
    V = zeros(size(A));
    for i =1:length(v)
        V(:,i) = eigvector(A,v(i),tol);
    end
end
function [v,A2,jb] = eigvector(A,eigvalue,tol)
%example A = [4     2     2; 2     5     1; 2     1     6]   
    if nargin ==2
        tol = 1e-10;
    end
    n =size(A,1);
    E = eye(n);
    A1 = A-eigvalue*E;
    [A2,jb]=GJ(A1,tol);
    v = ones(n,1);
    v(jb) = -A2(jb,end);
    v = v./norm(v,2);
end