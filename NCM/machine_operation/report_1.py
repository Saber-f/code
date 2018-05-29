# 拉格朗日插值
import sympy
import matplotlib.pyplot as plt
import numpy as np
class Lagrange: # 拉格朗日插值计算的类
    def get_data(self): # 获取数据
        print("Please Input Data::")
        self.x = [];self.y = []
        t = input("x::").split()
        for i in t:
            self.x.append(float(i))
        t = input("f(x)::").split()
        for i in t:
            self.y.append(float(i))
        
    def compute(self): # 计算插值多项式
        self.l = []
        self.x_ = sympy.symbols('x')
        for t1 in self.x:
            self.l.append(1)
            for t2 in self.x:
                if t1 != t2:
                    self.l[-1] *= (self.x_ - t2)/(t1 - t2)
        self.L = 0
        for t in range(len(self.l)):
            self.L += self.y[t]*self.l[t]
        
    def display(self): # 展示计算结果
        print("\nRresult::")
        print("f(x) = ",self.L,"\n     = ",sympy.expand(self.L),"\n")
        x_i = input("请输入您想要计算的x::").split()
        for t in x_i:
            print("f(%g) = %g"%(float(t),self.L.subs(self.x_,float(t))))
        plt.scatter(self.x,self.y)
        px = np.arange(min(self.x),max(self.x),(max(self.x) - min(self.x)) / 100)
        py = []
        for t in px:
            py.append( self.L.subs(self.x_,t))
        plt.plot(px,py)
        plt.show()
            

    
L = Lagrange()
L.get_data() 
L.compute()        
L.display()   

