def df(x,y):
    return x/y

def RK(xb,xe,y0,d):
    while xb <= xe:
        k1 = df(xb,y0)
        k2 = df(xb+d/2,y0+k1*d/2)
        k3 = df(xb+d/2,y0+k2*d/2)
        k4 = df(xb+d,y0+k3*d)
        y0 += d*(k1+2*k2+2*k3+k4)/6
        xb += d
        print("f(%.2f)="%xb,y0)

data = input().split()
RK(float(data[0]),float(data[1]),float(data[2]),float(data[3]))