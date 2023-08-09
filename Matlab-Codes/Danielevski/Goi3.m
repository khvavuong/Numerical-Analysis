function [A1, S, Sinv] = Goi3(A,k)
    % trong trường hợp 'pivot elem' = 0 nhưng tìm được phần tử thay thế
    % đưa phần tử thay thế về vị trí pivoting và trả ra phép biến đổi tương
    % ứng
    n =size(A,1);
    S = eye(n);
    [~, j] = max(abs(A(k,1:k-1)));
    S(:,[j, k-1]) = S(:, [k-1, j]);
    Sinv = S;
    A1 = S*A*Sinv;
end