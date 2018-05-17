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
    global peo
    global peos_1
    global peos_2
    global l_n # n的dec进制位数
    n = int(input("请输入待分解的数::")) # 待分解整数
    dec = 2  # 列表进制
    peo = 200 # 人口
    if peo % 2 != 0:
        peo += 1
    peos_1 = []
    peos_2 = []

    l_n = 0;t = n
    while t > 0:
        l_n += 1
        t //= dec
    i = 0
    while i < peo:
        j = 0
        t = []
        peos_2.append([])
        while j < l_n:
            t.append(random.randint(0,dec-1))
            peos_2[i].append(0)
            j += 1
        peos_1.append(t)
        i += 1
    return peos_1

# 适应度函数+排序
N = 0
def f():
    global N
    i = 0;s2 = 0;s1 = 0;min = n;min_n = 0
    for l_t in peos_1:
        n_t1 = list2int(l_t[0:l_n//2])
        n_t2 = list2int(l_t[l_n//2:l_n])
        if n_t1 == n_t2:
            rt2[i] = n
        else:
            rt2[i] = abs(n_t2*n_t2 % n - n_t1*n_t1 % n)
            if min > rt2[i]:
                min = rt2[i]
                min_n = i
        if rt2[i] == 0:
            print(n_t1,' ',n_t2)
            input()
        rt1[i] = 1 / rt2[i]
        s1 += rt1[i];s2 += rt2[i];i += 1
    rt1[0] /= s1;rt2[0] /= s2;i = 1
    while i < len(rt1)-1:
        rt1[i] = rt1[i]/s1 + rt1[i-1]
        i += 1
    rt1[i] = 1
    N += 1
    print(N,'::',min)
    return min_n

def ga():
    global rt1
    global rt2
    global peos_1
    global peos_2
    rt1 = [] # 被选取繁殖下一代的概率
    rt2 = [] # 变异，交叉概率由来
    i = 0 # 初始rt1、rt2
    while i < peo:
        rt1.append(0)
        rt2.append(0)
        i += 1
    
    # 迭代求解
    
    while True:
        min_n = f()# 获取新一轮的个体评价结果    
        num = 0     # 繁殖
        while num < peo:
            sel_n = [0,0] # xuan qu shuang qing
            sel = random.random()
            while sel > rt1[sel_n[0]]:
                sel_n[0] += 1
            sel = random.random()
            while sel > rt1[sel_n[1]]:
                sel_n[1] += 1

            sel = random.random();ex = [0,0] # jiao cha dian xuan ze
            if sel < 0.4 + rt2[sel_n[0]]*0.6:
                ex[0] = random.randint(0,l_n)
            sel = random.random();ex2 = 0
            if sel < 0.4 + rt2[sel_n[0]]*0.6:
                ex[1] = random.randint(0,l_n)
            ex.sort()
            
            i = 0
            while i < l_n:
                if i >= ex[0] and i < ex[1]:
                    sel = random.random()
                    if sel < rt2[sel_n[1]]*0.1 :
                        peos_2[num][i] = random.randint(0,dec-1)
                    else:
                        peos_2[num][i] = peos_1[sel_n[1]][i] 
                    
                    sel = random.random()
                    if sel < rt2[sel_n[0]]*0.1 :
                        peos_2[num+1][i] = random.randint(0,dec-1)
                    else:
                        peos_2[num+1][i] = peos_1[sel_n[0]][i]
                else:
                    sel = random.random()
                    if sel < rt2[sel_n[1]]*0.1 :
                        peos_2[num+1][i] = random.randint(0,dec-1)
                    else:
                        peos_2[num+1][i] = peos_1[sel_n[1]][i] 

                    sel = random.random()
                    if sel < rt2[sel_n[0]]*0.1 :
                        peos_2[num][i] = random.randint(0,dec-1)
                    else:
                        peos_2[num][i] = peos_1[sel_n[0]][i]
                i += 1
            num += 2
        j = 0
        for i in peos_1[min_n]:
            peos_2[0][j] = i
            j += 1
        t = peos_1;peos_1 = peos_2;peos_2 = t
    

def main():
    init() # 初始化
    ga()


main()



