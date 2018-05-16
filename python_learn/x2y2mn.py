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
    # 参数设定
    global n
    global dec #n列表表示的进度
    global peos_1
    global l_n # n的dec进制位数
    n = int(input("请输入待分解的数::")) # 待分解整数
    dec = 7  # 列表进制
    peo = 10 # 人口
    peos_1 = []

    l_n = 0;t = n
    while t > 0:
        l_n += 1
        t //= dec
    i = 0
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
def f():
    i = 0;s2 = 0;s1 = 0
    for l_t in peos_1:
        n_t1 = list2int(l_t[0:l_n//2])
        n_t2 = list2int(l_t[l_n//2:l_n])
        rt2[i] = abs(n_t2*n_t2 % n - n_t1*n_t1 % n)
        if rt2[i] == 0:
            print(n_t1,' ',n_t2)
            exit()
        rt1[i] = 1 / rt2[i]
        s1 += s1;s2 += s2;i += 1
    i = 0
    while i < len(rt1):
        rt1[i] /= s1
        rt2[i] /= s2
        i += 1
    print()

def ga():
    global rt1
    global rt2
    rt1 = [] # 被选取繁殖下一代的概率
    rt2 = [] # 变异，交叉概率由来
    i = 0 # 
    while i < len(peos_1):
        rt1.append(0)
        rt2.append(0)
        i == 1
    f()
    print(rt1)
    print(rt2)

def main():
    init() # 初始化
    ga()


main()



