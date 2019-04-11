import math
def dsin(a,b,n):
    d = (b-a)/n
    sum = 0
    x = a
    for i in range(n-1):
        x += d
        sum += math.sin(x)
    return (sum * 2 + math.sin(a) + math.sin(b))*d/2

e = 0.5e-3
n = 10
while True:
    r1 = dsin(0,1,n)
    n *= 2
    r2 = dsin(0,1,n)
    if abs(r1-r2) < e:
        break
print("dsin(0,1)=",r2)