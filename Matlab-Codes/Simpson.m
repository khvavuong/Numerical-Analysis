function [Iss, ss] = Simpson(x, y)
% so moc chia la so le
h = x(2)-x(1);
%buoc luoi min
Iss = h/3*(y(1)+y(end)+2*sum(y(3:2:end-2))+4*sum(y(2:2:end-1)));
% buoc luoi thua
I2h = 2*h/3*(y(1)+y(end)+2*sum(y(5:4:end-4))+4*sum(y(3:4:end-2)));
% danh gia sai so theo 2 buoc lien tiep
ss = 1/15*abs(Iss - I2h);
end