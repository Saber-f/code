'''Nonlinear equation Newton'''
from numpy import *
from sympy import *

def sum_list(L):
    t = L[0]
    i = 1
    while i < len(L):
        t += L[i]
        i += 1
    return t

def get_f():
    F = []
    print('pleace input f::')
    while True:
        f = input()
        if f == '':
            break;
        f = list(f)
        i = 0
        while i < len(f):
            if f[i] == 'x':
                f[i+1] = '['+str(int(f[i+1])-1)+']'
                i += 2
            else:
                i += 1
        F.append(sum_list(f))
    i = 0
    x = []
    while i < len(F):
        x.append(symbols('x'+str(i+1)))
        i += 1
    i = 0
    while i < len(F):
        F[i] = eval(F[i])
        i += 1
    return (F,x)

def Newton(F,x,e,N):
    i = 0
    while i < len(F):
        j = 0
        while j < len(x):

        j += 1
    i += 1


(F,x) = get_f()
print(F)

