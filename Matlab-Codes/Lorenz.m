f1 = @(x,y)10*(y-x);
f2 = @(x,y,z)23*x - y - x*z;
f3 = @(x,y,z)x*y - 8*z/3;

t0 = -10;
tn = 10;
h =0.01;
t = t0: h : tn;

Y0 = [1; 2; 3];

n = length(t);
KQ = zeros(3, n);
KQ(:,1) = Y0;

for i =1:n-1
    Y1 = KQ(:,i)+h*[f1(KQ(1,i),KQ(2,i));f2(KQ(1,i),KQ(2,i), KQ(3,i));f3(KQ(1,i),KQ(2,i), KQ(3,i))];
    KQ(:,i+1) = KQ(:,i) +h/2*([f1(KQ(1,i),KQ(2,i));f2(KQ(1,i),KQ(2,i), KQ(3,i));f3(KQ(1,i),KQ(2,i), KQ(3,i))]+...
        [f1(Y1(1),Y1(2)); f2(Y1(1),Y1(2), Y1(3)); f3(Y1(1),Y1(2), Y1(3))]);
end

plot(t,KQ(1,:));
hold on
plot(t,KQ(2,:));
plot(t,KQ(3,:));
legend('x(t)','y(t)','z(t)');

