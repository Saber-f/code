import random

def gcd(a,b):
    if b == 0:
        return a
    return gcd(b,a % b)

def rho(n):
    x = random.randint(1,10000)
    y = x
    i = 1
    k = 2
    c = 1
    while True:
        i += 1
        x = (x*x % n + c) % n
        if y == x: return n
        if y > x: p = y - x
        else: p = x - y
        d = gcd(p,n)
        if d != 1 and d != n:return d
        if i == k:y = x;k += k

def main():
    while True:
        n = eval(input("Input::"))
        if n == 0:
            break
        print(rho(n))    

main()