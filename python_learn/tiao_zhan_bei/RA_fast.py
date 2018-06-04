# 有理逼近算法
from time import *
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit  
import numpy as np  

def fai(l):
    return max([abs(l[0]),abs(l[1])])

def get_d(f,g):
    if g[0] == g[1]:
        t2 = -(f[0]+f[1])//(g[0]+g[1])
        if t2 % 2 == 0:
            t2 -= 1
        return [t2,t2+2]
    elif g[0] == -g[1]:
        t1 = (f[0]-f[1])//(g[0]-g[1])
        if t1 % 2 == 0:
            t1 -= 1
        return [t1,t1+2]
    else:
        t1 = (f[0]-f[1])//(g[0]-g[1])
        t2 = -(f[0]+f[1])//(g[0]+g[1])
        if t1 % 2 == 0:
            t1 -= 1
        if t2 % 2 == 0:
            t2 -= 1
        return [t1,t2,t1+2,t2+2]

def RA(a,x):
    Y = []
    a = a[:x[-1]]
    ti = time()
    I = 0
    for i in a:
        if i == '1':
            break
        I += 1
    a = a[I+1:]
    alf = 2**I
    t2 = alf*2
    f = [0,2]
    g = [alf,1]
    I += 1
    for m in a:
        I += 1
        t = t2
        if m == '1':
            alf += t
        t2 *= 2
        y = (alf*g[1] - g[0]) % t2
        if y == 0:
            f = [f[0]*2,f[1]*2]
        elif fai(g) < fai(f):
            d = get_d(f,g)
            g_ = [f[0]+d[0]*g[0],f[1]+d[0]*g[1]]
            for dd in d[1:]:
                g__ = [f[0]+dd*g[0],f[1]+dd*g[1]]
                if fai(g__) < fai(g_):
                    g_ = g__
            f = [g[0]*2,g[1]*2]
            g = g_
            '''
            g1 = f[1]+d[0]*g[1]
            if g1 < 0:
                g1 = -g1
            g0 = g1*alf % t2
            g0_ = g0 - t2
            if -g0_ < g0:
                g0 = g0_
            for td in d[1:]:
                g1_ = f[1]+td*g[1]
                if g1_ < 0:
                    g1_ = -g1_
                g0_ = g1_*alf % t2
                g0__ = g0_ - t2
                if -g0__ < g0_:
                    g0_ = g0__
                if fai([g0_,g1_]) < fai([g0,g1]):
                    [g0,g1] = [g0_,g1_]
            f = [g[0]*2,g[1]*2]
            g = [g0,g1]
            '''
        else:
            d = get_d(g,f)
            g_ = [g[0]+d[0]*f[0],g[1]+d[0]*f[1]]
            for dd in d[1:]:
                g__ = [g[0]+dd*f[0],g[1]+dd*f[1]]
                if fai(g__) < fai(g_):
                    g_ = g__
            f = [f[0]*2,f[1]*2]
            g = g_
            '''
            g1 = g[1]+d[0]*f[1]
            if g1 < 0:
                g1 = -g1
            g0 = g1*alf % t2
            g0_ = g0 - t2
            if -g0_ < g0:
                g0 = g0_
            for td in d[1:]:
                g1_ = g[1]+td*f[1]
                if g1_ < 0:
                    g1_ = -g1_
                g0_ = g1_*alf % t2
                g0__ = g0_ - t2
                if -g0__ < g0_:
                    g0_ = g0__
                if fai([g0_,g1_]) < fai([g0,g1]):
                   [g0,g1] = [g0_,g1_]
            f = [f[0]*2,f[1]*2]
            g = [g0,g1]
            '''
        if I % x[0] == 0:
            Y.append(time()-ti)
    return Y


def fund(x,a,b):
    return a*x**b

fo = open(r'C:\Users\Administrator\Documents\code\python_learn\tiao_zhan_bei\data.txt','r')
a = fo.read()
fo.close()
x = [100]
for i in range(800):
    x.append(x[-1]+100)
y = RA(a,x)
plt.plot(x,y,'b-')
popt, pcov = curve_fit(fund, x, y,[3.01782409e-12,2.82126279e+00],maxfev=1000)  
print(popt)
print(fund(1966000,popt[0],popt[1])/60/60/24)
y2 = [fund(i,popt[0],popt[1]) for i in x]
plt.plot(x,y2,'r--')
plt.show()