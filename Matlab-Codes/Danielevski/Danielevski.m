function [eigValues, P, Pinv] = Danielevski(A)
    count = size(A,1);
    n = size(A,1);
    eigValue = zeros(0,1);
    while count>0
         [eigValues,P, Pinv, A2] = GoiA(A);
         count = count - (n-size(A2));
         eigValues = [eigValue; eigValues];
    end
end