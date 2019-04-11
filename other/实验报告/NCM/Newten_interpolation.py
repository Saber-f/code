# n次牛顿插值
import numpy as np
import matplotlib.pyplot as plt
from sympy import *
print('please input data::')

# 输入数据
D = []
while True:
    d = input().split()
    if len(d) != 2:
        break
    d[0] = float(d[0])
    d[1] = float(d[1])
    D.extend([d])
# 输入数据结束

# 迭代开始
j = 1
while j < len(D):
    i = j
    while i < len(D):
        D[i].extend([(D[i][j] - D[i-1][j])/(D[i][0] - D[i-j][0])])
        i = i + 1
    j = j + 1
# 迭代结束

# 输出结果
print('')
i = 0
while i < len(D):
    j = 0
    while j < len(D[i]):
        print('%-20.2f'%(D[i][j]),end = ' ')
        j = j + 1
    print('')
    i = i + 1


x = symbols('x')
y = 0
i = 0
while i < len(D):
    j = 0
    t = D[i][i+1]
    while j < i:
        t = t * (x - D[j][0])
        j = j + 1
    y = y + t
    i = i + 1
ey = expand(y)
print('\n\n插值多项式为::',ey)

min = D[0][0]
max = D[0][0]
i = 1
while i < len(D):
    if D[i][0] < min:
        min = D[i][0]
    elif D[i][0] > max:
        max = D[i][0]
    i = i + 1
i = 0
sx = []
sy = []
while i < len(D):
    sx.extend([D[i][0]])
    sy.extend([D[i][1]])
    i = i + 1
plt.scatter(sx,sy)

px = np.arange(min,max,(max-min)/100)
py = []
for t in px:
    py.extend([y.subs(x,t)])
plt.plot(px,py)
plt.show()
# 输出结果结束
