function [v] = eigvalue(A,tol)
if nargin ==1
    tol = 1e-5;
end
        v = zeros(0,1);
        theta = eye(size(A,1));
        while length(v) < size(A,1)
            [vtr,vectr] = powerMethod(A,tol);
            if size(vectr, 2)==1
                A = XuongThang(A, vectr);
            else
                [A,theta] = XuongThang(A, vectr(:,1));
                [A,~] = XuongThang(A, theta*vectr(:,2));  
              end
            v=[v;vtr(:)];    
        end 
end

