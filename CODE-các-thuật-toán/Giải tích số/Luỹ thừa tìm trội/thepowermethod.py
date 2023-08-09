import numpy as np
import math
from numpy import linalg as LA

eps = 1e-6

# Hàm thu nhỏ các vector
def normalize(AmY):
    for i in range(len(AmY)):
        if (abs(AmY[i]) == LA.norm(AmY, np.inf)):
            AmY = AmY / AmY[i]
    return AmY


# Hàm tính luỹ thừa
def power(A, B, m):
    M = A.dot(B[m])
    M = normalize(M)
    return M


def powermethod(A, Y):
    B = []
    B.append(Y)

    B.append(power(A, B, 0))
    B.append(power(A, B, 1))
    m = 2
    TH = 3

    while True:
        if (LA.norm(B[m] - B[m-1], np.inf) < eps):
            TH = 1

            AmY = B[-1]
            Am1Y = A.dot(AmY)

            lamda = Am1Y[0] / AmY[0]

            print(f'Ma trận rơi vào TH{TH} sau {m} lần thực hiện luỹ thừa:')
            print('Giá trị riêng tìm được là: ', lamda)
            print('Vector riêng tìm được là: ')
            print(AmY)

            print('Kiểm tra lại kết quả: ')
            C = A.dot(AmY)
            D = lamda * AmY
            print('A.X - lamda.X =\n', (C - D))


            break

        if (LA.norm(B[m] - B[m-2], np.inf) < eps):
            TH = 2

            AmY = B[-1]
            Am1Y = A.dot(AmY)
            Am2Y = A.dot(Am1Y)
            Am3Y = A.dot(Am2Y)

            lamda1 = math.sqrt(Am3Y[0] / Am1Y[0])
            lamda2 = -lamda1

            v1 = normalize(Am1Y + lamda1*AmY)
            v2 = normalize(Am1Y - lamda1*AmY)

            print(f'Ma trận rơi vào TH{TH} sau {m} lần thực hiện luỹ thừa:')
            print('lamda1 = ', lamda1)
            print('v1 = ')
            print(v1)
            print('Kiểm tra lại kết quả: ')
            C1 = A.dot(v1)
            D1 = lamda1 * v1
            print('A.X - lamda.X =\n', (C1 - D1))
            print('\n')
            print('lamda2 = ', lamda2)
            print('v2 = ')
            print(v2)
            C2 = A.dot(v2)
            D2 = lamda2 * v2
            print('A.X - lamda.X =\n', (C2 - D2))

            break

        if m == 710:
            AmY = B[-1]
            Am1Y = A.dot(AmY)
            Am2Y = A.dot(Am1Y)
            a_1 = Am2Y[0][0]
            a_2 = Am2Y[1][0]
            b_1 = Am1Y[0][0]
            b_2 = Am1Y[1][0]
            c_1 = AmY[0][0]
            c_2 = AmY[1][0]

            a = 1
            b = (a_1 * c_2 - c_1 * a_2) / (c_1 * b_2 - b_1 * c_2)
            c = (b_1 * a_2 - a_1 * b_2) / (c_1 * b_2 - b_1 * c_2)

            print(f'Ma trận rơi vào TH{TH}:')
            print(f'Phươnng trình định thức = 0 tìm đc: Z^2 + {b}Z + {c} = 0 ')
            delta = b ** 2 - 4 * a * c
            if delta < 0:
                lamda1 = complex(-b / (2 * a), -math.sqrt(abs(delta)) / (2 * a))
                lamda2 = complex(-b / (2 * a), math.sqrt(abs(delta)) / (2 * a))
                v1 = normalize(Am2Y - lamda2 * Am1Y)
                v2 = normalize(Am2Y - lamda1 * Am1Y)

                print('lamda1 = ', lamda1)
                print('v1 = ')
                print(v1)
                C1 = A.dot(v1)
                D1 = lamda1 * v1
                print('A.X - lamda.X =\n', (C1 - D1))
                print('\n')
                print('lamda2 = ', lamda2)
                print('v2 = ')
                print(v2)
                C2 = A.dot(v2)
                D2 = lamda2 * v2
                print('A.X - lamda.X =\n', (C2 - D2))
            else:
                print('Đây là phương trình có nghiệm thực')
            break

        m = m + 1
        B.append(power(A, B, m - 1))


def main():
    A = np.loadtxt("A.txt", dtype = float, delimiter = ' ')
    n = A.shape[0]
    print("Ma trận đầu vào: ")
    print(A)
    Y = np.random.randint(1, 3, size = (n, 1))
    # X = np.loadtxt("Y.txt", dtype = float, delimiter = ' ')
    # Y= X.reshape(n, 1)
    print('vector Y: ')
    print(Y)


    powermethod(A, Y)

    # lamda, v = LA.eig(np.array(A))
    # print('*' * 50)
    # print('Kiểm tra lại kết quả bằng thư viện Numpy: ')
    # for i in range(n):
    #     print('lamda = ', lamda[i])
    #     print('v =')
    #     print(normalize(v[i]))
main()