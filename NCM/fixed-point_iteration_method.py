from sympy import *

x = symbols('x')
f = eval(input("Please input f(x)::"))
lb = eval(input("Please input lower bound::"))
ub = eval(input("Please input upper bound::"))
N = eval(input("Please input N::"))
e = eval(input("Please input e::"))

n = 0
x0 = (min + max)/2
while n < N:
    x0 = f.subs(x,x0)
    n += 1
