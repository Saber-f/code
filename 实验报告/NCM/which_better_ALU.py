def fm(n):
    i = 1
    S = 0
    while i < n:
        S += i*(i+1)
        i += 1
    return S

def fo(n):
    i = 1
    m = n-1
    S = 0
    while i < n:
        S += i*(n-i) + i*(m-i)
        i += 1
    return S

i = 2
N = eval(input("N::"))
i = N
while i <= N:
    tm = fm(i)
    to = fo(i)
    print(tm,' ',to,' ',tm/to)
    i +=1
