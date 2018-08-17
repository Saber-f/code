import sys

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
    D01 = [];flage = False
    for m in range(len(data_2[1])):
        D01.append([])
        for n in range(len(data_2[0])):
            D01[m].append(0)
    for m in data:
        x = data_2[1].index(m[1])
        y = data_2[0].index(m[0])
        D01[x][y] += 1
        if D01[x][y] > 1:
            flage = True
            print(data.index(m))
    if flage:
        return []
    return D01

# 返回m行n列的0矩阵
def zeros(m,n):
    A = []
    for i in range(m):
        A.append([])
        for j in range(n):
            A[i].append(0)
    return A


#评价函数数
#def f(D01,X):



def t(A):
    A[1][1] = 2
    print2(A)

def main():
    data = get_data() # 读取数据
    D01 = get_01(data) # 获取01矩阵
    if D01 == []:
        print("有重复数据!请处理！")
        return
    a = zeros(2,2)
    t(a)
    print2(a)

    


if __name__ == "__main__":
    main()