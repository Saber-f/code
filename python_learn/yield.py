'''生成器使用练习4147'''
import sys

def fibonacci(n_n):
    '''生成器函数 - 斐波那契'''
    n_a, n_b, n_c = 0, 1, 0
    while True:
        if n_c > n_n:
            return
        yield n_a
        n_a, n_b = n_b, n_a + n_b
        n_c += 1

F = fibonacci(11)

while True:
    try:
        print(next(F), end=" ")
    except StopIteration:
        sys.exit()
