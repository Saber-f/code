import sys
import time 
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
    f = open("data.txt",'r')
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
    print("科目数量",len(data_2[1]),"学生数量",len(data_2[0]))
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
    return [D01,all,data_2]

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
def f():
    global wp
    while wp < peo:
        Y[wp][0] = Y[wp][1] = Y[wp][2] = 0
        # 冲突记录初始化
        for i in range(num):
            for j in range(num_p):
                REM[wp][i][j] = 0
        for i in range(num_k):
            add(REM[wp][X[wp][i]],D01[i]) 
        # 每堂人数，方差
        for i in range(num):
            t[i] = 0
            for j in REM[wp][i]:
                t[i] += j
        for i in t:
            Y[wp][0] += abs(i-ave)
        # 冲突记录
        for i in REM[wp]:
            for j in i:
                if j > 2:
                    Y[wp][1] += 1
                elif j == 2:
                    Y[wp][2] += 1
        Score[wp] = Y[wp][0] + Y[wp][1] * 1000 + Y[wp][2]*100
        wp += 1

# a = b
def copy(a,b):
    for i in range(len(a)):
        a[i] = b[i]

def jiapei():
    global wp
    while wp < peo:
        a = int(peo*random.random()**2) # 随机产生父母
        b = int(peo*random.random()**2) # 产生不同的父母
        while a^b:
            b = int(peo*random.random()**2) # 产生不同的父母
        copy(father,X[S_i[a]]) 
        copy(mother,X[S_i[b]])
        # 交叉
        if random.random() < gj:
            w = randints(1,2*nj,0,num_k)[0]
            w.sort()
            for j in range(nj):
                for i in range(w[2*j],w[2*j+1]):
                    [father[i],mother[i]] = [mother[i],father[i]]           
         # 变异
        for i in range(len(father)):
            if random.random() < gb:
                father[i] = random.randint(0,num-1)
            if random.random() < gb:
                mother[i] = random.randint(0,num-1)
        if wp < peo:
            copy(X_[wp],father)
            wp += 1
        if wp < peo:
            copy(X_[wp],mother)
            wp += 1

def ga():
    global wp 
    global X 
    global X_
    global S_i
    for d in range(dyn):
        # 评价
        wp = 0
        f() #评价
        S_i = [index for index,value in sorted(list(enumerate(Score)),key=lambda x:x[1])] # Score排序索引
        copy(X_[0],X[S_i[0]]) # 保留最优解
        wp = 1 # 新增个体记录
        gj = 0.4 + 0.6*(1-d/dyn) # 交叉概率变化
        gb = 0.1*(1-d/dyn) # 变异概率变化
        jiapei() # 繁殖
        X_t = X;X = X_;X_ = X_t
        print(" 进度::%04.1f"%(100*d/dyn),end = '%\r')
    
    # 评价最后的结果
    wp = 0
    f()
    S_i = [index for index,value in sorted(list(enumerate(Score)),key=lambda x:x[1])] # Score排序索引
    return [X[S_i[0]],Y[S_i[0]]]


def write_ans():
    f = open("reult.xls",'w+')
    cf = 0
    for i in range(len(data)):
        data[i].append(x_b[data_2[1].index(data[i][1])]+1)
        for j in range(i):
            if data[i][0] == data[j][0] and data[i][2] == data[j][2]:
                cf += 1
                data[i].append(cf)
                data[j].append(cf)
    for i in data:
        if len(i) == 3:
            f.writelines("%d\t%d\t%d\n"%(i[0],i[1],i[2]))
        else:
            f.writelines("%d\t%d\t%d\t%d\n"%(i[0],i[1],i[2],i[3]))
    f.close()


data = get_data() # 读取数据
[D01,all,data_2] = get_01(data) # 获取01矩阵，若有重复数据，D01返回为[]
if D01 == []: 
    input("有重复数据!请处理!")
    exit
num_k = len(D01) #补考科目数
num_p = len(D01[0]) #补考人数
num = int(input("请输入考试堂数::"))
peo = 300 # 种群规模
dyn = 150 # 进化代数
cishu = int(input("请输入循环次数::")) # 循环次数
father = zeros(1,num_k)[0] # 初始话父亲
mother = zeros(1,num_k)[0] # 初始化母亲
REM = []
for i in range(peo):
    REM.append(zeros(num,num_p)) # 记录安排后的01矩阵
t = zeros(1,num)[0] # 记录每堂人数
X_ = zeros(peo,len(D01)) #储存下一代结果
Y = zeros(peo,3) # 记录评价结果
Score = zeros(1,peo)[0] # 记录得分
ave = all/num # 计算每堂考试平均人数
nj = 6 # 交叉互换段数
gj = 0.9 # 交叉概率
gb = 0.1 # 变异概率
y_b = 100
t_all = 0
for i in range(cishu):
    start = time.time()
    X = randints(peo,len(D01),0,num-1) # 随机初始解
    print("%d、"%(i+1))
    if i:
        X[0] = X_r
    [X_r,Y_r] = ga() # 使用遗传算法
    stop = time.time()
    t_all += stop - start
    print("本次用时::%.2fs   总用时::%.2fs"%(stop-start,t_all))
    print("两科冲突人数:%d  两科以上冲突人数:%d"%(Y_r[2],Y_r[1]))
    if y_b > Y_r[2]:
        y_b = Y_r[2]
        x_b = X_r
write_ans() # 写入安排结果
input("回车结束") 