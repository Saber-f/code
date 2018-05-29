# 牛顿插值
import sympy
import matplotlib.pyplot as plt
import numpy as np

# x -2 0 1 2
# y 17 1 2 19

class Newton: # 牛顿插值计算的类
    def get_data(self): # 获取数据
        self.time = int(input("Please input the time of newton::")) + 1
        print("Please Input Data::")
        self.x = [];self.y = []
        t = input("x::").split()
        for i in t:
            self.x.append(float(i))
        t = input("f(x)::").split()
        for i in t:
            self.y.append(float(i))
			
    def difference_quotient(self): # 根据输入的x,y计算差商
        self.dq = [self.y]
        print()
        for i in range(len(self.x)-1):
            t = []
            for j in range(len(self.x)-i-1):
                t.append((self.dq[i][j+1]-self.dq[i][j])/(self.x[i+j+1]-self.x[j]))
            print(i+1,"阶差商::",t)
            self.dq.append(t)
                
    def compute(self): # 计算插值多项式
        self.l = []
        self.x_ = sympy.symbols('x')
        for i in range(self.time):
            self.l.append(self.dq[i][0])
            for j in range(i):
                self.l[-1] *= (self.x_ - self.x[j] )
        self.L = 0
        for t in self.l:
            self.L += t

    def display(self): # 展示计算结果
        print("\nRresult::")
        print("f(x) = ",self.L,"\n     = ",sympy.expand(self.L),"\n")
        x_i = input("请输入您想要计算的x::").split()
        for t in x_i:
            print("f(%g) = %g"%(float(t),self.L.subs(self.x_,float(t))))
        plt.scatter(self.x,self.y)
        px = np.arange(min(self.x),max(self.x),(max(self.x) - min(self.x)) / 1000)
        py = []
        for t in px:
            py.append( self.L.subs(self.x_,t))
        plt.plot(px,py)
        plt.show()

NT = Newton()
NT.get_data()
NT.difference_quotient()
NT.compute()
NT.display()