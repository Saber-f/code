from multiprocessing import Pool
import time

def f(n):
    ans = 1
    for t in range(1,n):
        ans *= t
    return ans

def main():
    a = []
    for i in range(20000000):
        a.append(1)
    t = time.time()
    for i in a:
        f(i)
    print(time.time()-t)
    t = time.time()
    p = Pool(4)
    p.map(f,a)
    p.close()
    p.join()
    print(time.time()-t)
    
    
if __name__ == "__main__":
    main()
