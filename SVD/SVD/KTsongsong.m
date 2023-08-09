function check = KTsongsong(u,v,tol)
    check =(norm( u./norm(u,2)-v./norm(v,2), 2)<=tol)||(norm( u./norm(u,2)+v./norm(v,2), 2)<=tol);
end