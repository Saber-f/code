'''get prime'''
import timeit

def get_prime(n):
    N = 5
    N_c = N
    while True:
        t = 3
        while t <= N/t:
            if N % t == 0:
                N += 2
                t = 3
            else:
                 t += 2
        n -= 1
        print(N - N_c,end = ' ')
        N_c = N
        if n == 0:
            break
        N += 2
    print()
    print(N)

def get_prime2(n):
    N = 5
    while True:
        t = 3
        while t*t <= N:
            if N % t == 0:
                N += 2
                t = 3
            else:
                 t += 2
        n -= 1
        if n == 0:
            break
        N += 2
    print(N)

n = eval(input('Input::'))
t1 = timeit.default_timer()
get_prime(n)
t2 = timeit.default_timer()
print(t2-t1)
t1 = timeit.default_timer()
get_prime2(n)
t2 = timeit.default_timer()
print(t2-t1)
