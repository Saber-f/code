import sys
import random

# 打印二维矩阵
def print2(A):
    for m in A:
        for n in m:
            print(n,end = ' ')
        print()

# 一维字符列表转数字列表
def list_str2num(A):
    i = 0
    while i < len(A):
        A[i] = int(A[i])
        i += 1
    return A

# 读取数据
def get_data():
    f = open("data.txt")
    line = f.readline()
    data = []
    while line:
        data.append(list_str2num(line.split()))
        line = f.readline()
    f.close()
    return data

# 转置
def zhuanzhi(A):
    B = []
    for t in A[0]:
        B.append([])
    length = len(A[0])
    for m in A:
        if len(m) != length:
            return []
        for n in range(length):
            B[n].append(m[n])
    return B

# 得到01矩阵
def get_01(data):
    data_2 = zhuanzhi(data)
    data_2[0] = sorted(list(set(data_2[0]))) # 学生编号
    data_2[1] = sorted(list(set(data_2[1]))) # 科目编号
    D01 = zeros(len(data_2[1],),len(data_2[0]));flage = False
    all = 0
    for m in data:
        x = data_2[1].index(m[1])
        y = data_2[0].index(m[0])
        D01[x][y] += 1
        all += 1
        if D01[x][y] > 1:
            flage = True
            print(data.index(m))
    if flage:
        return []
    return [D01,all]

# 返回m行n列的0矩阵
def zeros(m,n):
    A = []
    for i in range(m):
        A.append([])
        for j in range(n):
            A[i].append(0)
    return A

# 返回m行n列的0矩阵
def randints(m,n,a,b):
    A = []
    for i in range(m):
        A.append([])
        for j in range(n):
            A[i].append(random.randint(a,b))
    return A

# a = a + b
def add(a,b):
    for i in range(len(a)):
        a[i] += b[i]

#评价函数数
def f(D01,X,REM,Y,t,ave,num):
    Y[0] = Y[1] = Y[2] = 0
    # 冲突记录初始化
    for i in range(len(REM)):
        for j in range(len(REM[0])):
            REM[i][j] = 0
    for i in range(len(X)):
        add(REM[X[i]%num],D01[i]) 
    # 每堂人数，方差
    for i in range(len(t)):
        t[i] = 0
        for j in REM[i]:
            t[i] += j
    for i in t:
        Y[0] += abs(i-ave)
    # 冲突记录
    for i in range(len(REM)):
        for j in range(len(REM[0])):
            if REM[i][j] > 2:
                Y[1] += 1
            elif REM[i][j] == 2:
                Y[2] += 1

# a = b
def copy(a,b):
    for i in range(len(a)):
        a[i] = b[i]

def join(b,X_,peo,num_k,n):
    if n < peo:
        for i in range(peo):
            for j in range(num_k):
                if X_[i][j] != b[j]:
                    break
                if j == num_k - 1:
                    return n
        copy(X_[n],b)
        return n + 1
    else:
        return n

def ga(D01,all,num,peo,dyn):
    N = 1
    X = randints(peo,len(D01),0,N*num-1) # 随机初始解
    X_ = zeros(peo,len(D01))
    num_k = len(D01)
    father = zeros(1,num_k)[0]
    mother = zeros(1,num_k)[0]
    REM = zeros(num,len(D01[0]))
    Y = zeros(1,3)[0]
    t = zeros(1,num)[0]
    Score = zeros(1,peo)[0]
    ave = all/num

    for d in range(dyn):
        for j in range(peo):
            f(D01,X[j],REM,Y,t,ave,num)
            Score[j] = Y[0] + Y[1] * 100 + Y[2]*10
        S_i = [index for index,value in sorted(list(enumerate(Score)),key=lambda x:x[1])] # Score排序索引
        copy(X_[0],X[S_i[0]]) # 保留最优解
        n = 1
        while True:
            a = int(peo*random.random()**2)
            while True:
                b = int(peo*random.random()**2)
                if a^b:
                    break
            copy(father,X[S_i[a]])
            copy(mother,X[S_i[b]])
            # 交叉
            if random.random() < 0.1 + 0.8/(1+60*d/dyn):
                w = randints(1,2,0,num_k)[0]
                while w[0] == w[1]:
                    w = randints(1,2,0,num_k)[0]
                for i in range(w[0],w[1]):
                    [father[i],mother[i]] = [mother[i],father[i]]           
            # 变异
            for i in range(len(father)):
                if random.random() < 0.1/(1+60*d/dyn):
                    father[i] = random.randint(0,N*num-1)
                if random.random() < 0.1/(1+60*d*0.1):
                    mother[i] = random.randint(0,N*num-1)
            n = join(father,X_,peo,num_k,n)
            n = join(mother,X_,peo,num_k,n)
            if n >= peo:
                break
        X_t = X;X = X_;X_ = X_t
    f(D01,X[0],REM,Y,t,ave,num)
    return [X[0],Y,t]


def main():
    data = get_data() # 读取数据
    [D01,all] = get_01(data) # 获取01矩阵
    num = 8#int(input("请输入考试堂数"))
    peo = 300
    dyn = 60
    if D01 == []:
        print("有重复数据!请处理！")
        return
    [X,Y,t] = ga(D01,all,num,peo,dyn)
    print2([X])
    print2([Y])
    print2([t])

if __name__ == "__main__":
    main()