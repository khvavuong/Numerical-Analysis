Chương trình có sử dụng các hàm trong file thư viện mymath.h

Sau đây là một số hàm sử dụng trong chương trình có nguồn gốc từ thư viện trên.
matran A(a,b) khai báo ma trận A có a hàng, b cột.
A.gmatran(a,b,c) gán A[a][b]= c
A.omatran(a,b) trả về giá trị của A[a][b] (kiểu long double)
A.gc() trả về số cột của ma trận A (kiểu int)
A.gr() trả về số hàng của ma trận A (kiểu int)
A.in() in ma trận ra màn hình

Dữ liệu đầu vào được đọc từ file txt. Nội dung của file gồm hai phần:
- Dòng đầu là số hàng của ma trận vuông.
- Từ dòng thứ hai là nội dung ma trận.
Ví du với ma trận 3x3: 

3
15 23 31
45 54 63
71 82 95

Tiếp đó các bạn đặt tên nó là matrancplus2.txt
Chương trình có lưu kết quả tại tệp ketquacplus2.txt.
