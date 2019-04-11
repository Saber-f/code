from random import randint
from os import system
from time import sleep
from time import time
from matplotlib import pyplot
'''
2048模拟
'''

A = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
C = ['w','a','s','d']
flage = True #是否可以添加


def print2(A):
    '''
    打印矩阵
    '''
    print()
    for i in A:
        for j in i:
            print(j,end=' ')
        print()

def add(A):
    '''
    新增值
    '''
    global flage
    n = 0
    s = []
    for i in A:
        for j in i:
            if j == 0:
                s.append(n)
            n = n + 1 
    if len(s) == 0:
        return -1
    if flage:
        n = randint(0,len(s)-1)
        A[s[n]//4][s[n]%4] = 1
        flage = False
        return 1
    else:
        return 

def move(A,c):
    global flage
    if c == 'w':
        for i in range(4):
            for j in range(1,4):
                if A[j][i] != 0:
                    #向上移动到顶
                    k = j
                    while k > 0:
                        if A[k-1][i] == 0:
                            A[k-1][i] = A[k][i]
                            A[k][i] = 0
                            k = k - 1
                            flage = True
                        elif A[k-1][i] == A[k][i]:
                            A[k-1][i] = A[k][i] + 1
                            A[k][i] = 0
                            k = k - 1
                            flage = True
                        else:
                            break
    elif c == 'a':
        for i in range(4):
            for j in range(1,4):
                if A[i][j] != 0:
                    #向左移动到头
                    k = j
                    while k > 0:
                        if A[i][k-1] == 0:
                            A[i][k-1] = A[i][k]
                            A[i][k] = 0
                            k = k - 1
                            flage = True
                        elif A[i][k-1] == A[i][k]:
                            A[i][k-1] = A[i][k] + 1
                            A[i][k] = 0
                            k = k - 1
                            flage = True
                        else:
                            break
    elif c == 's':
        for i in range(4):
            for j in range(2,-1,-1):
                if A[j][i] != 0:
                    #向下移动到底
                    k = j
                    while k < 3:
                        if A[k+1][i] == 0:
                            A[k+1][i] = A[k][i]
                            A[k][i] = 0
                            k = k + 1
                            flage = True
                        elif A[k+1][i] == A[k][i]:
                            A[k+1][i] = A[k][i] + 1
                            A[k][i] = 0
                            k = k + 1
                            flage = True
                        else:
                            break
    elif c == 'd':
        for i in range(4):
            for j in range(2,-1,-1):
                if A[i][j] != 0:
                    #向下移动到底
                    k = j
                    while k < 3:
                        if A[i][k+1] == 0:
                            A[i][k+1] = A[i][k]
                            A[i][k] = 0
                            k = k + 1
                            flage = True
                        elif A[i][k+1] == A[i][k]:
                            A[i][k+1] = A[i][k] + 1
                            A[i][k] = 0
                            k = k + 1
                            flage = True
                        else:
                            break

def score(A):
    sc = 0
    for i in A:
        for j in i:
            sc = sc + 2**j
    return sc

N = 1000
ans = []
time_start = time()

#随机方法
for i in range(N):
    flage = True
    add(A)
    while True:
        t = randint(0,3)
        move(A,C[t])
        t = add(A)
        if t == -1:
            ans.append(score(A))
            A = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
            break
'''

for i in range(N):
    flage = True
    add(A)
    while True:
        move(A,'s');f1 = not flage
        add(A)
        move(A,'a');f2 = not flage
        add(A)
        if f1 and f2:
            move(A,'d');f1 = not flage
            add(A)
            move(A,'a');f2 = not flage
            add(A)
            if f1 and f2:
                move(A,'w')
                f1 = add(A)
                move(A,'a');f2 = flage
                f2 = add(A)
                if f1 == -1 and f2 == -1:
                    ans.append(score(A))
                    A = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]]
                    break
'''

time_end = time()
ans.sort()
print(time_end-time_start)
print(sum(ans)/N)

pyplot.plot(ans)
pyplot.show()