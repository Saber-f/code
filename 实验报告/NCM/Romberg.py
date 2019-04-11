def f(x):
    return x**3 + x**2

def rb(a,b,e,M):
    n = 1
    h = b -a
    R1 = [(f(a) + f(b)) * h / 2]
    R2 = []
    k = 2
    while k <= M:
        s = 0
        i = 1
        while i <= 2**(k-2):
            s += f(a + (2*i - 1)*h/2**(k-1))
            i += 1
        R2.insert(0,(R1[0] + h / 2**(k-2) * s) / 2)
        R2.append(0);
        j = 1
        while j < k:
            R2[j] = R2[j-1] + (R2[j-1] - R1[j-1])/(4**j-1)
            j += 1
        t = R2;R2 = R1;R1 = t;
        if abs(R1[k-1] - R2[k-2]) < e:
            break
        k += 1
    return R1[k-1]


print(rb(1,2,0.0001,100))
