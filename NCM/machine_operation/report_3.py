# 分段插值
import sympy
import matplotlib.pyplot as plt
import numpy as np

class piecewise_interpolation:
    def get_data(self): # 获取数据
        x_ = sympy.symbols('x')
        self.time = int(input("Input the time of piecewise interpolation::")) # 分段插值次数
        print("Please Input Data::")
        self.x = [];self.y = []
        t = input("x::").split(
        for i in t:
            self.x.append(float(i))
        t = input("f(x)::").split()
        for i in t:
            self.y.append(float(i))

    def pi_L(self,x,y): # 拉格朗日插值
        l = []
        for t1 in x:
            l.append(1)
            for t2 in x:
                if t1 != t2:
                    l[-1] *= (self.x_ - t2)/(t1 - t2)
        L = 0
        for t in range(len(self.l)):
            L += y[t]*l[t]
        return L

    def compute(): # 计算



piecewise_interpolation PI;
PI.get_data()
PI.compute()