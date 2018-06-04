# 有理逼近算法
from time import *
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

fo = open(r'C:\Users\Administrator\Documents\code\python_learn\tiao_zhan_bei\data.txt','r')
a = fo.read()
fo.close()
a = a[:40000]
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
ti = time()
for m in a:
    t = t2
    if m == '1':
        alf += t
    t2 *= 2
    if (alf*g[1] - g[0]) % t2 == 0:
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
    else:
        d = get_d(g,f)
        g_ = [g[0]+d[0]*f[0],g[1]+d[0]*f[1]]
        for dd in d[1:]:
            g__ = [g[0]+dd*f[0],g[1]+dd*f[1]]
            if fai(g__) < fai(g_):
                g_ = g__
        f = [f[0]*2,f[1]*2]
        g = g_
print(time()-ti)