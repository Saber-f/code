from numpy import *

def p(B):
    for i in B:
        for j in i:
            print("%7.3f"%j,end = ' ')
        print()

B = []
print("please input data::")
while True:
    t = input().split()
    if t == []:
        break
    x = []
    for i in t:
        x.append(float(i))
    B.append(x)

B = array(B)
for i in range(len(B)-1):
    for j in range(i+1,len(B)):
        B[j] -= B[i]*(B[j,i]/B[i,i])
    p(B);print()
for i in range(1,len(B))[::-1]:
    for j in range(0,i)[::-1]:
        B[j] -= B[i]*(B[j,i]/B[i,i])
    p(B);print()
for i in range(len(B)):
    B[i] /= B[i,i]
p(B)