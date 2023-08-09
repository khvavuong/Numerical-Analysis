function heSo = LeastSquare(x, y, Phi)
%[x; y] la bang B
% Phi la vecto hang chua cac ham co so
% Phi = [phi_1, phi_2, .. , phi_m]
A = double(subs(Phi(:), x));
y = y(:);
heSo = (A*A')\(A*y);
end