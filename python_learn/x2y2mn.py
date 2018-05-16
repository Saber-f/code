# 遗传算法求解x^2+y^2=n 
import random 
import math

def int2list(n):
    l = [];     
    while n > 0:
        l.insert(0,n%dec)
        n //= dec 
    return l

def list2int(l):
    n = 0
    for t in l:
        n *= dec
        n += t
    return n

def init():
    global n
    global dec #n列表表示的进度
    global peos_1
    global l_n # n的dec进制位数
    # 参数设定
    n = int(input("请输入待分解的数::")) # 待分解整数
    dec = 7  # 列表进制
    peo = 10 # 人口
    peos_1 = []

    l_n = 0;t = n
    while t > 0:
        l_n += 1
        t //= dec
    i = 0
    print('l_n::',l_n,' ',' ',peo)
    while i < peo:
        j = 0
        t = []
        while j < l_n:
            t.append(random.randint(0,dec-1))
            j += 1
        peos_1.append(t)
        i += 1
    return peos_1

# 适应度函数+排序
def f(l):
    rt = [] # 评价结果
    for l_t in l:
        n_t1 = list2int(l_t[0:l_n//2])
        n_t2 = list2int(l_t[l_n//2:l_n])
        rt.append(abs(n_t2*n_t2 % n - n_t1*n_t1 % n))
    return rt

def ga():
    rt = f(peos_1)
    print(rt)

def main():
    init() # 初始化
    ga()
    print(peos_1)

main()



