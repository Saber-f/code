#RSA
import random
import time

def gcd(a,b):
    if a > b:
        if b == 0:
            return a
        else:
            return gcd(b,a%b)
    else:
        if a == 0:
            return b 
        else:
            return gcd(a,b%a)


def xnp(x,n,p):               #x^n%p快速计算
    r = 1
    x_ = x % p
    for t in bin(n)[2:][::-1]:
        if t == '1':
            r = r*x_%p
        x_ = x_*x_ % p
    return r

def PrimeQ(n,t):              #Miller-Rabin素性测定
    for i in range(2,t+2):
        n_ = n - 1
        while n_%2 == 0:
            if xnp(i,n_,n) != 1:
                return False
            n_ //= 2
    return True
    
def get_prime():              #得到伪素数
    n = random.randint(10e100,10e200)
    if n%2 == 0:
        n += 1
    while not PrimeQ(n,100):  #误判率为1/4^100
        n += 2
    return n

def mod_n(e,fn):            #返回d使得ed=1mod(fn)
    a = fn;b = e
    l = []
    while True:
        if a%b == 1:
            uv = [1,-(a//b)]
            break
        l.append(a//b)
        [a,b] = [b,a%b]
    for i in l[::-1]:
        uv.append(uv[-2]-uv[-1]*i)
    return uv[-1]%fn

def get():
    p = get_prime()
    q = get_prime()
    n = p*q;fn = (p-1)*(q-1)
    e = random.randint(10e100,10e200)
    while gcd(e,fn) != 1:
        e += 1
    d = mod_n(e,fn)
    print("\n公开::");print("n::",n);print("e::",e)
    print("\n保密::");print("p::",p);print("q::",q);print("d::",d);print("fai(n)::",fn,"\n\n")

def RSA():
    n = int(input("\n\n请输入n::"))
    de = int(input("请输入e(d)::"))
    num = int(input("输入数字::"))
    num = xnp(num,de,n)
    print("结果::",num,"\n\n")

while True:
    o = int(input("1、获取公钥和私钥。\n2、加(解密)。\n0、退出。\n"))
    if(o == 1):
        get()
    elif(o == 2):
        RSA()
    else:
        break