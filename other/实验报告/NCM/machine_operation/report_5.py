def f(x):
    return x**3 + x**2 - 1

def f0(x,d,e):
    d /= 2
    x_ = x+d
    y_ = f(x_)
    print("f(",x_,")=",y_)
    if abs(x - x_) < e:
        return x_
    elif y_ < 0:
        return f0(x_,d,e)
    elif y_ > 0:
        return f0(x,d,e)
    else:
        return x_
        
f0(0,1-0,1e-3)

    