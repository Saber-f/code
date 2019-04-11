def f1(a):
    a -= 2
    a = a * 100 - 30
    if a > 0:
        t = 10
        while t < 20:
            t = t + 3
            a += t
        pass
    elif a == 0:
        a = 666
    else:
        a = -999
    return a

def f2(b):
    b = 3 * b + 5
    b *= 2
    b -= 3
    t = 5
    while t >= -1:
        b += t
        t -= 1
        if b < 0:
            break
    return b

def f3(c):
    if c < 100 and c > 22:
        c = 66
    elif not c > 1000 or c < -100:
        c = 2**4
        c **= 2
    return c
    pass

if __name__ == '__main__':
    a = 123
    b = 234 + a
    a += b
    b = f1(a)
    c = f2(b)
    c *= 2
    c = f3(c)
    pass