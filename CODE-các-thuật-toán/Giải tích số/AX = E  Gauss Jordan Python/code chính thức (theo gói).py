# Khai báo sử dụng thư viện Numpy
from numpy import *
import numpy as np

#=================================================================================
# tạo ra 2 ma trận rỗng
index_cot  = []  # Mảng lưu các cột của phần tử giải (theo thứ tự)
index_hang = []  # Mảng lưu các hàng của phần tử giải (theo thứ tự)
#=================================================================================
# Tìm phần tử giải
# ưu tiên |a| = 1
# nếu ko thấy thì lấy phần tử có |a| MAX
def TimPhanTuGiai():
    global index_hang, index_cot
    index_temp = []
    maxvalue = 0
    for row in range(0, n):
        if row in index_hang:  # Bỏ qua vì hàng này đã có phần tử giải
            continue

        
        # Nếu có 1 hoặc -1 trong hàng row => chọn làm phần tử giải
        # Lưu giá trị phần tử giải, tìm vị trí trên ma trận
        if (1 in A[row, 0:(len(A[0]))]) or (-1 in A[row, 0:(len(A[0]))]):  
            maxvalue = 1
            hang = row
            index_temp = np.where(abs(A[row, 0:(len(A[0]))]) == maxvalue)
            index_temp = index_temp[:1]
            index_temp = index_temp[0][0]
            break
        
        else:
            # Tìm phần tử có trị tuyệt đối lớn nhất trong hàng row
            max_row = np.amax(abs( A[row, 0:(len(A[0]))] )) 
            if max_row > maxvalue:  
                maxvalue = max_row
                hang = row
                index_temp = np.where(abs(A[row, 0:(len(A[0]))]) == maxvalue)
                index_temp = index_temp[:1]
                index_temp = index_temp[0][0]
    
    # Lưu vị trí hàng và cột của phần tử giải 
    if maxvalue != 0:  # Lưu vị trí hàng và cột của phần tử giải
        index_hang.append(hang)
        index_cot.append(int(index_temp))
        
        print(f'vị trí phần tử giải: A{hang+1}{index_temp+1} = {A[hang, index_temp]} ')
        print('=> Biến đổi cột, ta có ma trận [A|E] ở dưới:\n')
    else:
        print("Ma trận không khả nghịch!!!!")
        quit()            

#==========================================================================================
# Thuật toán GaussJordan
# Quy trình khử [A|E]
def GaussJordan():
    global A,e
    
    TimPhanTuGiai()
    zeros_A = np.zeros([n,n])  # Tạo 1 ma trận không
    zeros_E = np.zeros([n,n])  # Tạo 1 ma trận không
    
    
    # Khử trên ma trận [A|E]
    for row in range(0, n):
        
        # index_hang[-1] nghĩa là chỉ hàng của 'phần tử giải' mới tìm thấy
        if row == index_hang[-1]:
            continue
        
        # tìm m
        m = - A[row][index_cot[-1]] / A[index_hang[-1]][index_cot[-1]]
        zeros_A[row] = A[index_hang[-1]] * m
        zeros_E[row] = e[index_hang[-1]] * m
        
    A = A + zeros_A
    e = e + zeros_E
    print(A,'\n\n',e,'\n')
    print('________________________________________________')

#========================================================================================
# Chuẩn hóa hệ số bằng 1
# ở mỗi hàng của [A|E] chia cho phần tử giải của hàng đó
def chuanhoaheso():
    for i in range(len(index_hang)):
        e[index_hang[i]] = e[index_hang[i]] / A[index_hang[i]][index_cot[i]]
        A[index_hang[i]] = A[index_hang[i]] / A[index_hang[i]][index_cot[i]]
        
#========================================================================================
# Sắp xếp lại các hàng sao cho
# Ma trận  [A|E]  khi biến đổi sang [E| A^(-1)]
# nếu ở trên là 1 và ở dưới là 0 => Return 1   => giữ nguyên
# nếu ở trên là 0 và ở dưới là 1 => Return - 1 => đổi chỗ 2 hàng
def SapXepHang():
    
    # Kiểm tra 2 dãy bất kỳ 
    # So sánh 2 phần tử của 2 dãy trên cùng 1 cột
    def SoSanh(a, b, n):
        check = 0
        for i in range(n):
            if (a[i] == 1) and (b[i] < 1): return 1
            elif (a[i] < 1) and (b[i] == 1): return -1
        return  check

    for i in range(n):
        for j in range(0, n-i-1):
            if SoSanh(A[j], A[j+1], n) == -1:
                for k in range(n):
                    A[j,k], A[j+1, k] = A[j+1, k], A[j, k]
                    e[j, k], e[j + 1, k] = e[j + 1, k], e[j, k]

#========================================================================================
# Chương trình chính
# input Ma trận vuông A cỡ (nxn)
A = np.loadtxt("input.txt", dtype="float", delimiter=" ")
Old_A = A
n = len(A)
print('Ma trận đã cho\n', A)
    
# Tạo Ma trận đơn vị của A
e = eye(n)

print('\n\n__________________________________________________________________')
for i in range(0, n):
    GaussJordan()

print ('Ma trận [A|E] sau khi khử :\n\n',A,'\n\n',e)    

chuanhoaheso()
print('\n\n__________________________________________________________________')
print ('Ma trận [A|E] sau khi chuẩn hóa hệ số 1:\n\n',A,'\n\n',e)    
                
SapXepHang()
print('\n\n__________________________________________________________________')
print ('Ma trận  [A|E]  khi biến đổi sang [E| A^(-1)] :\n\n',A,'\n\n',e)    

print('\n\n__________________________________________________________________')
print("Ma trận nghịch đảo là:\n")
print(e)

#========================================================================================
# Kiểm tra
print('\n\n__________________________________________________________________')
print('Kiểm tra lại:\n')
test = Old_A.dot(e) - eye(n)
print('A.A^(-1) - E = \n',test,'\n')