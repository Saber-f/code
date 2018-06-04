# 有理逼近算法

def fai(l):
    return max([abs(l[0]),abs(l[1])])

def list_2(l):
    return [l[0]*2,l[1]*2]

def add_l(a,b,c,alf,t2):
    num_ = num = 1
    pq = [a[0]+b[0]*c[0],abs(a[1]+b[0]*c[1])]
    pq[0] = pq[1]*alf % t2
    t_ = pq[0] - t2
    if -t_ < pq[0]:
        pq[0] = t_
#    print('=======================',pq,end=' ')
    for d in b[1:]:
        num += 1
        pq_ = [a[0]+d*c[0],abs(a[1]+d*c[1])]
        t_ = pq_[0] - t2
        if -t_ < pq[0]:
            pq_[0] = t_
#        print(pq_,end=' ')
        if fai(pq_) < fai(pq):
            pq = pq_
            num_ = num
    if num_ == len(b):
        input('num_太大 ')
    print("   ------>",num_,'   ',len(b))
    return pq

def get_d(f,g):
    t1 = (f[0]-f[1])//(g[0]-g[1])
    t2 = -(f[0]+f[1])//(g[0]+g[1])
    if t1 % 2 == 0:
        t1 += 1
    if t2 % 2 == 0:
        t2 += 1
    ans = [t1,t2]
    for i in range(1,100):
        ans.extend([t1+i*2,t1-i*2,t2+i*2,t2-i*2])
    return ans

def RA(a):
    t = 0
    for i in a:
        if i == '1':
            break
        t += 1
    a = a[t+1:]
    alf = 2**t
    t2 = alf*2
    f = [0,2]
    g = [alf,1]
    I = 1 ###################3
    for i in a:
        I += 1
#        if I % 1000 == 0:
#            print(I)
        t = t2
        if i == '1':
            alf += t
        t2 *= 2
        if (alf*g[1] - g[0]) % t2 == 0:
            f = list_2(f)
        elif fai(g) < fai(f):
            d = get_d(f,g)
            [g,f] = [add_l(f,d,g,alf,t2),list_2(g)]
        else:
            d = get_d(g,f)
            [g,f] = [add_l(g,d,f,alf,t2),list_2(f)]

#        print(g,' ',alf,' ',t2)
    print(g)

fo = open(r'C:\Users\Administrator\Documents\code\python_learn\tiao_zhan_bei\data.txt','r')
a = fo.read()
fo.close()
N = int(input("How many::"))
RA(a)