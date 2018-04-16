# 最小二乘法，矩阵及平方和解
from numpy import *
from sympy import *

x = symbols('x')

# 获取数据
def get_data():
    E = input("请输入表达式::").split()
    i = 0
    while i < len(E):
        E[i] = eval(E[i])
        i += 1
    X = input("请输入x::").split()
    i = 0
    while i < len(X):
        X[i] = eval(X[i])
        i += 1
    while True:
        Y = input("请输入y::").split()
        if len(X) == len(Y):
            break
    i = 0
    while i < len(Y):
        # Y[i] = float(log(eval(Y[i])))
        Y[i] = eval(Y[i])
        i += 1
    return (E, X, Y)

# 矩阵求解
def Matrix_solution(E, X, Y):
    A = mat(random.rand(len(X), len(E)))
    B = mat(random.rand(len(Y),1))
    i = 0
    while i < len(X):
        j = 0
        B[i,0] = Y[i];
        while j < len(E):
            if type(E[j]) == int or type(E[j]) == float:
                A[i,j] = E[j]
            else:
                A[i,j] = E[j].subs(x,X[i])
            j += 1
        i += 1
    return (A, B, (A.T * A).I * A.T * B)

# 平方和解法
def Square_sum_solution(X, Y, E):
    # 加入符号系数
    i = 0
    a = []
    while i < len(E):
        a.append(symbols('a'+str(i)))
        i += 1
    Q = 0
    i = 0
    while i < len(X):
        j = 0
        t = 0
        while j < len(E):
            if type(E[j]) == int or type(E[j]) == float:
                t += E[j] * a[j]
            else:
                t += E[j].subs(x,X[i]) * a[j]
            j += 1
        t -= Y[i]
        Q += t**2
        i += 1
    A = mat(random.rand(len(E),len(E)+1))
    i = 0
    print('\nQ::',expand(Q),'\n')
    while i < len(E):
        q = diff(Q,a[i])
        print('dQ/d'+str(a[i]),q,' = 0')
        j = len(E)
        while j >= 0:
            t = q
            k = 0
            while k < len(E):
                if k == j:
                    t = t.subs(a[k],1)
                else:
                    t = t.subs(a[k],0)
                k += 1
            if j == len(E):
                A[i,j] = -t
            else:
                A[i,j] = t + A[i,len(E)]
            j -= 1
        i += 1
    return A[:,0:len(E)].I*A[:,len(E)]

# dedaowucha
def get_e(A, B, a):
    t = A*a - B
    return t.T * t

# 主函数
def main():
    (E, X, Y) = get_data()
    (A, B, a) = Matrix_solution(E, X, Y)
    print('\nA::\n',A,'\n\nB::\n',B,'\n\na::\n',a,'\n\ne:',get_e(A, B, a),'\n\n\n')
    a = Square_sum_solution(X, Y, E)
    print('\na::\n',a,'\n\ne:',get_e(A, B, a))

main()
