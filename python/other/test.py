# 打印斐波拉契数列

def Fibonacci(n):
    if n < 1:
        print('n必须大于0 ！')
        return 0
    t1 = 0
    t2 = 1
    
    while True:
        n = n -1
        if n < 1:
            return t2
        t = t1 + t2
        t1 = t2
        t2 = t


if __name__ == "__main__":
    n = int(input('请输入n::'))
    f = Fibonacci(n)
    if f > 0:
        print('第%d个斐波那契数列是:%d'%(n,f))