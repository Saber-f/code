'''get prime'''
import timeit

def get_prime(n):
    L = [3]
    tail = 0
    while n != 0:
        L.append(L[tail]+2)
        tail += 1
        t = 0
        while L[t]*L[t] <= L[tail]:
            if L[tail] % L[t]:
                L[tail] += 2
                t = 0
            else:
                t += 1
        n -= 1
        if n == 0:
            break;
    print()

def get_prime2(n):
    N = 3
    while n != 0:
        N += 2
        t = 3
        while t*t <= N:
            if N % t == 0:
                N += 2
                t = 3
            else:
                 t += 2
        n -= 1
    print(N)

n = eval(input('Input::'))
t1 = timeit.default_timer()
# get_prime(n)
t2 = timeit.default_timer()
print(t2-t1)
t1 = timeit.default_timer()
get_prime2(n)
t2 = timeit.default_timer()
print(t2-t1)
