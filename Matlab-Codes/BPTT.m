function Val = BPTT(x,y,Phi,u)
heSo = LeastSquare(x,y,Phi);
f = Phi*heSo;
Val = double(subs(f, u));
end