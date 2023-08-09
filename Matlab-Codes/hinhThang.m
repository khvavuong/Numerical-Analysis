function [Iht, ss] = hinhThang(x, y)
% so moc chia la so le
h = x(2)-x(1);
%buoc luoi min
Iht = h/2*(y(1)+y(end)+2*sum(y(2:end-1)));
% buoc luoi thua
I2h = h*(y(1)+y(end)+2*sum(y(3:2:end-2)));
% danh gia sai so theo 2 buoc lien tiep
ss = 1/3*abs(Iht - I2h);
end