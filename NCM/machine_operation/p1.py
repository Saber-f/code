#x = eval(input("请输入x::"))
x = [0.0, 0.5, 1.0, 2**0.5, 10.0, 100.0, 300.0]

def f(x):
    k = 0
    Sum = 0
    while k < 10**3:
        k += 1  
        Sum += 1/(k*(k+x))
    print("Ans:: %.6f"%Sum)

i = 0
while i < len(x):
    print("x::%10.6f"%x[i],end = '  ')
    f(x[i])
    i += 1