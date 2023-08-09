clc
clear all
alpha =[0 2/10 -3/10;-7/20 0 4/20; 10/30 5/30 0];
beta = [12/10;15/20;-18/30];
x0=[1.2564000;  0.2964250;  -0.1452500];
%x0=[0;0;0];
q=norm(alpha,inf);
heso =q/(1-q);
x1=alpha*x0+beta;
fprintf('%4.7f  %4.7f  %4.7f\n',x1)
i=1;
while heso*norm(x1-x0,inf)/norm(x1)>0.03
    x0=x1;
    x1=alpha*x0+beta;
    i=i+1;
    fprintf('%4.7f  %4.7f  %4.7f\n',x1)
end
disp(i)
