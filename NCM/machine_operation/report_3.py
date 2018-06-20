# 分段插值
import sympy
import matplotlib.pyplot as plt
import numpy as np

class piecewise_interpolation:
    def get_data(self): # 获取数据
        x_ = sympy.symbols('x')
        print("Please Input Data::")
        self.x = [];self.y = []
        t = input("x::").split()
        for i in t:
            self.x.append(float(i))
        t = input("f(x)::").split()
        for i in t:
            self.y.append(float(i))
        self.n = int(inut("Please n::"))

    def compute(): # 计算
        self.ans = np.zeros(len(self.x)-1,)



PI = piecewise_interpolation()
PI.get_data()
PI.compute()