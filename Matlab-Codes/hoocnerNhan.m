function q = hoocnerNhan(p, c)
n = length(p);
p = p(:)';
p = [p, 0];
q = zeros(1, n+1);
q(1) = p(1);
for i = 1:n
    q(i+1) =p(i+1)- c*p(i);
end
end