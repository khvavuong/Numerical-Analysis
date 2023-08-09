function [A, jb] = GJ(A, tol)

[m,n] = size(A);

% Loop over the entire matrix.
i = 1;
j = 1;
%create empty row vector
jb = zeros(1,0);
while i <= m && j <= n
   % Find value and index of largest element in the remainder of column j.
   [p, k] = max(abs(A(i:m,j)));
   k = k+i-1;
   if p < tol
      % The column is negligible, zero it out.
      A(i:m,j) = 0;
      j = j + 1;
   else
      % Remember column index
      jb = [jb j]; %#ok<AGROW>
      % Swap i-th and k-th rows.
      A([i k],j:n) = A([k i],j:n);
      % Divide the pivot row by the pivot element.
      A(i,j:n) = A(i,j:n)./A(i,j);
      % Subtract multiples of the pivot row from all the other rows.
      for k = [1:i-1 i+1:m]
         A(k,j:n) = A(k,j:n) - A(k,j).*A(i,j:n);
      end
      i = i + 1;
      j = j + 1;
   end
end