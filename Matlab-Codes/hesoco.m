function q = hesoco(g, a, b)
% g la ham so dang symbolic
% (a, b) la khoang phan ly nghiem
t = linspace(a, b, 1001);
dg = diff(g);
y = subs(dg, t);
q = max(abs(y));
q = double(q);
end