# n次拉格朗日插值
from sympy import * 
import matplotlib.pyplot as plt
def li(i,X): #返回li(x)
    x = symbols('x')
    lx = 1
    j = 0
    while j < len(X):
        if j != i:
            lx = lx * (x - X[j]) / (X[i] - X[j])
        j = j + 1
    return lx

def Ln(X,Y): #返回n次朗日插值多项式
    i = 0
    Lnx = 0
    while i < len(Y):
        Lnx = Lnx + li(i,X)*Y[i]
        i = i + 1
    return Lnx
        
def inputxy():
    print('please input data::')
    X = []
    Y = []
    while True:
        d = input().split()
        if len(d) != 2:
            break;
        X.extend([float(d[0])])
        Y.extend([float(d[1])])
    return X,Y

def plotxy(X,Y,Lnx): #画出插值多项式以及已知点的图像
    plt.scatter(X,Y)
    px = arange(min(X),max(X),(max(X) - min(X)) / 100);
    py = []
    for t in px:
        py.extend([Lnx.subs(x,t)])
    plt.plot(px,py)
    plt.show()

# 函数调用
X,Y = inputxy()
Lnx = Ln(X,Y)
print('插值多项式为::',expand(Lnx))
plotxy(X,Y,Lnx)
