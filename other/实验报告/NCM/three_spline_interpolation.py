'''三次样条插值，矩阵解'''
from numpy import *
import numpy as np
import matplotlib.pyplot as plt

# 将字符列表转换为浮点数列表
def str2float(L):
    i = 0;
    while i < len(L):
        L[i] = float(L[i])
        i += 1

# 得到m x n 的零矩阵
def get_mat(m,n):
    A = []
    i = 0
    while i < m:
        j = 0
        A.append([])
        while j < n:
            A[i].append(0)
            j += 1
        i += 1
    A = mat(A)
    return A

# 加入f(xi)=yi
def F1(A, B, X, Y):
    i = 1
    while i < len(X):
        A[2*i-2,4*i-4] = X[i-1]**3
        A[2*i-2,4*i-3] = X[i-1]**2
        A[2*i-2,4*i-2] = X[i-1]
        A[2*i-2,4*i-1] = 1
        B[2*i-2,0] = Y[i-1]
        A[2*i-1,4*i-4] = X[i]**3
        A[2*i-1,4*i-3] = X[i]**2
        A[2*i-1,4*i-2] = X[i]
        A[2*i-1,4*i-1] = 1
        B[2*i-1,0] = Y[i]
        i += 1

# 加入边界条件一二阶导数相等条件
def F2(A,X):
    i = 2*(len(X)-1)
    j = 1
    while j < len(X) - 1:
        A[i,4*j-4] = 3*X[j]**2
        A[i,4*j-3] = 2*X[j]
        A[i,4*j-2] = 1
        A[i,4*j] = -3*X[j]**2
        A[i,4*j+1] = -2*X[j]
        A[i,4*j+2] = -1
        A[i+len(X)-2,4*j-4] = 6 * X[j]
        A[i+len(X)-2,4*j-3] = 2
        A[i+len(X)-2,4*j] = -6 * X[j]
        A[i+len(X)-2,4*j+1] = -2
        j += 1
        i += 1

# 加入边界条件
def F3(A, B, X):
    print('边界条件::')
    f10 = input('f\'('+str(X[0])+') = ')
    f20 = input('f\'\'('+str(X[0])+') = ')
    f1n = input('f\'('+str(X[len(X)-1])+') = ')
    f2n = input('f\'\'('+str(X[len(X)-1])+') = ')
    i = 1;
    if f10 != '':
        A[len(A)-i,0] = 3*X[0]**2
        A[len(A)-i,1] = 2*X[0]
        A[len(A)-i,2] = 1
        B[len(A)-i,0] = f10
        i += 1
    if f1n != '':
        A[len(A)-i,len(A)-4] = 3*X[len(X)-1]**2
        A[len(A)-i,len(A)-3] = 2*X[len(X)-1]
        A[len(A)-i,len(A)-2] = 1
        B[len(A)-i,0] = f1n
        i += 1
    if f20 != '' and i < 3:
        A[len(A)-i,0] = 6*X[0]
        A[len(A)-i,1] = 2
        B[len(A)-i,0] = f20
        i += 1
    if f2n != '' and i < 3:
        A[len(A)-i,len(A)-4] = 6*X[len(X)-1]
        A[len(A)-i,len(A)-3] = 2
        B[len(A)-i,0] = f2n
        i += 1

# 得到答案（系数矩阵）
def get_ans(A, B):
    temp = A.I*B;
    ANS = []
    i = 0
    while i < len(B) / 4:
        ANS.append([]);
        ANS[i].append(temp[i*4,0])
        ANS[i].append(temp[i*4+1,0])
        ANS[i].append(temp[i*4+2,0])
        ANS[i].append(temp[i*4+3,0])
        i += 1
    return mat(ANS)

# 画图
def plot_ans(A,X):
    i = 1
    while i < len(X):
        px = np.arange(min(X[i-1],X[i]),max(X[i-1],X[i])+abs(X[i]-X[i-1])/1000,abs(X[i]-X[i-1])/100)
        j = 0
        py = []
        while j < len(px):
            py.append(A[i-1,0]*px[j]**3+A[i-1,1]*px[j]**2+A[i-1,2]*px[j]+A[i-1,3])
            j += 1
        plt.plot(px,py)
        i += 1
    plt.show()

# 求导
def deriva(ANS):
    i = 0
    while i < len(ANS):
        j = 3
        while j > 0:
            ANS[i,j] = ANS[i,j-1]*(4-j)
            j -= 1
        ANS[i,0] = 0;
        i += 1

while True:
    tX = input('请输入x::').split()
    tY = input('请输入y::').split()
    if len(tX) == len(tY):
        s = np.argsort(tX)
        X = []
        Y = []
        for t in s:
           X.append(tX[t])
           Y.append(tY[t])
        X = tX
        Y = tY
        break

str2float(X)
str2float(Y)

A = get_mat(4*(len(X)-1),4*(len(X)-1))
B = get_mat(4*(len(X)-1),1)

F1(A, B, X, Y)
F2(A, X)
F3(A, B, X)

ANS = get_ans(A, B)
print(ANS)
plt.scatter(X,Y,marker = 'x')
plot_ans(ANS,X)
deriva(ANS)
plot_ans(ANS,X)
deriva(ANS)
plot_ans(ANS,X)
deriva(ANS)
plot_ans(ANS,X)


