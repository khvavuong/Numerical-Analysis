function w = ChinhTac(x)
n = length(x);
w = [1 -x(1)];
for i =2:n
    w = hoocnerNhan(w,x(i));
end
end