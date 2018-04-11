''' 因式分解 '''

def next_prime(N):
    t = 3
    while t < N:
        if N % t == 0:
            t = 3
            N += 2
        t += 2
    return N
        
def factorization(n):
    print('1',end = '')
    if n < 4:
        print(' ',n)
    elif n == 4:
        print(' ','2^2')
    else:
        t = 5
        nt = 0
        while n != 1:
            while n % t == 0:
                nt += 1
                n = int(n/t)
            if nt != 0:
                print(' ',t,'^',nt,ent = '')
                nt = 0
            
n = eval(input('please input::'))
factorization(n)