# 分段插值
print("Please Input Data::")
x = [];y = []
t = input("x::").split()
for i in t:
    x.append(float(i))
t = input("y::").split()
for i in t:
    y.append(float(i))
t = input("x you want to complete::").split()
xj = []
for i in t:
    xj.append(float(i))
yj = []
for i in xj:
    for j in range(len(x)-1):
        if i > x[j] and  i < x[j+1]:
            yj.append(y[j] + (y[j+1]-y[j])*(i-x[j])/(x[j+1]-x[j]))
            print("f(",i,")=",yj[-1])
