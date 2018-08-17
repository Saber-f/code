# 有理逼近算法

class ra:
    def find_d(self,m,n,x,y):
        d = [0,0]
        s = [0,0]
        if x*y >= 0:
            z = -((x+y)//(m+n))
        else:
            z = -((x-y)//(m-n))
        if z > 0:
            z -= 1

        if z%2 == 1:
            d[0] = z
            d[1] = z + 2
        else:
            d[0] = z - 1
            d[1] = z + 1
        s[0] = min(abs(m + d[0]*x),abs(n + d[0]*y))
        s[1] = min(abs(m + d[1]*x),abs(n + d[1]*y))
        return min(s)


    def updata(self,a,b,c,d):
        h = max(abs(a),abs(b))
        g = max(abs(c),abs(d))

        if h >= g:
            w = self.find_d(a,b,c,d)
            a += w * c
            b += w * d
            c *= 2
            d *= 2
        else:
            w = self.find_d(c,d,a,b)
            [v1,v2,v3,v4] = [a,b,c,d]
            a = v3 + w*v1
            b = v4 + w*v2
            c = 2*v1
            d = 2*v2

        return([a,b,c,d])


    def RA(self, a):
        N = len(a)

        # 初始化
        t = 0
        for i in a:
            if i == '1':
                break
            t += 1         # 获得序列中第一个不为0的角标t
        if t < N:
            p = alf = 2**t
            q = 1
            P = 0
            Q = 2
        else:
            p = 0
            q = 1
            
        # 迭代
        for k in range(t+1,N-1):
            if a[k] == '1':
                alf += 2**k
            if p == (q*alf)%(2**(k+1)):
                P *= 2
                Q *= 2
            else:
                [p,q,P,Q] = self.updata(p,q,P,Q)

        # 输出结果
        self.show(p,q)


    def show(self,p,q):
        print('p::',p)
        print('q::',q)


a = '01111111100010101011'
R = ra()
R.RA(a)

'''
if(x*y>=0,
z=-(m+n)\(x+y);if(z%2==1,d[1]=z;d[2]=z+2,d[1]=z-1;d[2]=z+1;);s[1]=compare(m+d[1]*x,n+d[1]*y);s[2]=compare(m+d[2]*x,n+d[2]*y);if(s[1]>=s[2],return(d[2]),return(d[1]);),
z=-(m-n)\(x-y);if(z%2==1,d[1]=z;d[2]=z+2,d[1]=z-1;d[2]=z+1;);s[1]=compare(m+d[1]*x,n+d[1]*y);s[2]=compare(m+d[2]*x,n+d[2]*y);if(s[1]>=s[2],return(d[2]),return(d[1]);););

'''