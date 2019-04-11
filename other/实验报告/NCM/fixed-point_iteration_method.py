from sympy import *

# 输入表达式及参数
x = symbols('x')
f = eval(input("Please input x = "))
lb = eval(input("Please input lower bound::"))
ub = eval(input("Please input upper bound::"))
N = eval(input("Please input N::"))
e = eval(input("Please input e::"))

# 得到函数f(x)在区间[a,b]上的最大最小值得近似值
def min_max(f,a,b):
    d =  (b - a)/1000
    if d > 0.001:
        d = 0.001
    min = f.subs('x',a)
    max = min
    while a <= b:
        a += d
        t = f.subs('x',a)
        if t < min:
            min = t
        elif t > max:
            max = t
    return (min,max)

'''
# 判断是否收敛
#(1) a <= x <= b ,a <= f(x) <=  b
(min,max) = min_max(f,lb,ub)
if min < lb or max > ub:
    print("不满足收敛条件(1)")
    exit()
#(2) max(f'(x)) < 1
(min,max) = min_max(diff(f,x),lb,ub)
if max >= 1:
    print("不满足收敛条件(2)")
    exit()
'''

n = 0
x0 = (lb + ub)/2
while n <= N:
    x1 = f.subs('x',x0)
    if abs(x1 - x0) < e:
        break
    n += 1
    print('x0 = ',x0)
    print('x1 = ',x1)
    x0 = x1
