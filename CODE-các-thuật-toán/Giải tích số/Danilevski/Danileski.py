from NewtonHorner import *
import numpy as np


def Case1(A, row):
    # tạo ra ma trận M cho phép biến đổi trên A
    n = A.shape[0]
    M = np.eye(n)
    M[row - 1, :] = A[row, :]

    # tạo ra ma trận nghịch đảo M
    inverseM = np.eye(n)
    inverseM[row - 1, :] = -A[row, :] / A[row, row - 1]
    inverseM[row - 1, row - 1] = 1 / A[row, row - 1]

    # similarA = M*A*inverseM
    similarA = M.dot(A).dot(inverseM)
    return similarA,inverseM


def Case2(A, row, col):
    # thực hiện đổi chỗ luôn các hàng và cột của ma trận A thay vì nhân ma trận

    copA = A.copy()
    copA[[row - 1,col], :] = copA[[col, row - 1], :]
    copA[:, [row - 1, col]] = copA[:, [col, row - 1]]
    return copA


def getPolynomialCoefficients(matrixFrobenius):
    # Lấy hệ số của đa thức đặc trưng từ ma trận dạng F

    size = matrixFrobenius.shape[0]
    polynomialCoefficients = (-1) ** size * np.ones(size + 1)
    polynomialCoefficients[1:] = polynomialCoefficients[1:] * (-1) * matrixFrobenius[0, :]
    return polynomialCoefficients


def findEigenValue(matrixFrobenius):
    # Truyền vào hệ số của đa thức đặc trưng để giải

    p = getPolynomialCoefficients(matrixFrobenius)
    p = list(p)[::-1]
    eigenValues = findRoots(p)
    return sorted(eigenValues)


def Danilevski(A):
    sizeOfA = A.shape[0]
    back = np.eye(sizeOfA)
    similar = A.copy()
    list_eigenvalues = []
    list_eigenvectors = []
    row = sizeOfA - 1
    tmpSize = sizeOfA

    while row > 0:
        # Trường hợp 1
        if similar[row, row - 1] != 0:
            similar, inverseM = Case1(similar, row)
            back = back.dot(inverseM)
            print(f'\nCase 1, vị trí đang xét: {row + 1},{row} ')
            print(similar)
        else:
            # Trường hợp 2
            case2 = False
            for col in range(0, row - 1):
                if similar[row, col] != 0:
                    similar = Case2(similar, row, col)
                    back[:, [col, row - 1]] = back[:, [row - 1, col]]
                    print(f'\nCase 2,vị trí đang xét: {row + 1}, {row}')
                    print(similar)
                    case2 = True
                    row = row + 1
                    break

            # Trường hợp 3
            if not case2:
                for col in range(row, tmpSize - 1):
                    S = np.eye(tmpSize)
                    S[:row, col + 1] = -similar[:row, col]
                    inverseS = np.eye(tmpSize)
                    inverseS[:row, col + 1] = similar[:row, col]
                    similar = S.dot(similar).dot(inverseS)
                    back = back.dot(inverseS)
                    print(f'\nCase 3, vị trí đang xét: {row + 1}, {row}')
                    print(similar)

                # Trường hợp 3.1
                case3_1 = False
                for _row in range(row - 1, -1, -1):
                    if similar[_row, tmpSize - 1] != 0:
                        U = np.eye(tmpSize)
                        x = U[row:tmpSize, :]
                        y = U[row - 1, :]
                        U = np.vstack([U[0:row - 1, :], x, y])
                        inverseU = U.T
                        similar = U.dot(similar).dot(inverseU)
                        back = back.dot(inverseU)
                        print(f'\nCase 3.1, vị trí đang xét: {row + 1}, {row}')
                        print(similar)
                        row = tmpSize
                        case3_1 = True
                        break

                # Trường hợp 3.2
                if not case3_1:
                    print(f'\nCase 3.2, vị trí đang xét: {row + 1}, {row}')
                    print(similar)
                    X = similar[row:sizeOfA, row:sizeOfA]         # X đã là ma trận Frobenius
                    print('Ma trận dạng Frobenius nhận được là: ')
                    print(X)
                    H = getPolynomialCoefficients(X)
                    print('Hệ số của đa thức đặc trưng là: ', H)
                    sizeOfX = X.shape[0]
                    eigenValues = findEigenValue(X)
                    print('Giá trị riêng tìm được là: ', eigenValues)
                    for j in range(len(eigenValues)):
                        print("\nVector riêng ứng với trị riêng(case3.2): ", eigenValues[j])
                        list_eigenvalues.append(eigenValues[j])
                        eigenVectorOfX = np.power(eigenValues[j], np.arange(sizeOfX))[::-1].reshape((sizeOfX, 1))
                        eigenVectorOfA = np.zeros((sizeOfA, 1))
                        p = np.zeros((tmpSize, 1))
                        p[row:tmpSize] = eigenVectorOfX
                        p = back.dot(p)
                        eigenVectorOfA[:tmpSize] = p
                        list_eigenvectors.append(eigenVectorOfA)
                        print(eigenVectorOfA)
                    tmpSize = row
                    similar = similar[:row, :row]
                    print('Ma trận A sau khi tách khối Frobenius: ')
                    print(similar)
                    back = np.eye(tmpSize)
        row = row - 1

    X = similar        # X đã là ma trận Frobenius
    sizeOfX = X.shape[0]
    print(f'Ma trận dạng Frobenius cuối cùng nhận được cỡ {sizeOfX}: ')
    print(similar)
    Z = getPolynomialCoefficients(similar)
    print('Hệ số của đa thức đặc trưng là: ', Z)
    eigenValues = findEigenValue(X)
    print('Giá trị riêng tìm được là: ', eigenValues)

    for j in range(len(eigenValues)):
        print("\nVector riêng ứng với trị riêng: ", eigenValues[j])
        list_eigenvalues.append(eigenValues[j])
        eigenVectorOfX = np.power(eigenValues[j], np.arange(sizeOfX))[::-1].reshape((sizeOfX, 1))
        p = np.zeros((tmpSize, 1))
        eigenVectorOfA = np.zeros((sizeOfA, 1))
        p[row:tmpSize] = eigenVectorOfX
        p = back.dot(p)
        eigenVectorOfA[:tmpSize] = p
        list_eigenvectors.append(eigenVectorOfA)
        print(eigenVectorOfA)
    return list_eigenvalues, list_eigenvectors


def main():
    A = np.loadtxt("A.txt", dtype = float, delimiter = ' ')
    print('Ma trận đầu vào: ')
    print(A)
    if A.shape[0] != A.shape[1]:
        print('Ma trận A không phải là ma trận vuông!')
    else:
        eigenvalues, eigenvectors = Danilevski(A)
        print('\nKiểm tra kết quả: ')
        for i in range(len(eigenvalues)):
            B = A.dot(eigenvectors[i])
            C = eigenvalues[i] * eigenvectors[i]
            print('\nlamda = ', eigenvalues[i])
            print('A.X - lamda.X =\n', (B - C))


main()

