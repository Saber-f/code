def f(x):
    return x*x - 11

def df(x):
    return 2*x 

def ND(x,e):
    y = f(x)
    dy = df(x)
    print("f(",x,")=",y)
    if y > 0:
        x_ = x - y/dy
    elif y > 0:
        x_ = x + y/dy
    else:
        return x
    if abs(x - x_) < e:
        return x_
    else:
        return ND(x_,e)

x = ND(4,1e-10)
print("f(",x,")=",f(x))