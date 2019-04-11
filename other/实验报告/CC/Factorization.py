''' 因式分解 '''

def next_prime(N):
    t = 3
    N += 2
    while t*t <= N:
        if N % t == 0:
            t = 3
            N += 2
        t += 2
    return N

def factorization(n):
    print('1',end = '')
    if n < 4:
        print(' '+str(n))
    else:
        nt = 0
        while n % 2 == 0:
            nt += 1
            n = int(n/2)
        if nt != 0:
            print(' 2^'+str(nt),end = '')
            nt = 0
        t = 3
        while n != 1:
            while n % t == 0:
                nt += 1
                n = int(n/t)
            if nt != 0:
                print(' '+str(t)+'^'+str(nt),end = '')
                nt = 0
            t = next_prime(t)
        print()

n = eval(input('please input::'))
factorization(n)
