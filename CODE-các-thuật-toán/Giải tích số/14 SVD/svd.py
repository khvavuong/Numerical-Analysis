import numpy as np
import csv

mat_ = []
row = []
with open("input.csv", "r") as file:
    reader = csv.reader(file)
    for i in reader:
        row = i
        for j in range (len(row)):
            row[j] = float(row[j])
        mat_.append(row)
mat = np.matrix(mat_)
u, s, vh = np.linalg.svd(mat)
print(f"U = {u}")
size = np.shape(mat)
sf = np.zeros(size)
for i in range (np.size(s)):
    sf[i][i] = s[i]
print(f"S = {sf}")
print(f"V = {vh.T}")
print(u * sf * vh)
