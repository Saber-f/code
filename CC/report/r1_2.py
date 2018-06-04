import tkinter as tk
import tkinter.font as tkFont  

class classical_encryption:
    def __init__(self):                         # 初始化
        self.win = tk.Tk()                      # 创建

    def encrypt(self):                          # 加密
        self.model = False
        self.fun()

    def decode(self):                                         # 解密
        self.model = True
        self.fun()

    def fun(self):
        MC = list(self.MC.get())
        K = list(self.K.get())  
        K = list(set(K))                                     # 去重
#====================================加解密开始==============================================
        cK = K.copy()                                        # 获取索引
        s = [];cK.sort()
        for t in cK:
            s.append(K.index(t))

        cK = []
        for i in range(len(MC)%len(K)):
            cK.append(K[i])
        s_ = [];cK.sort()
        for t in cK:
            s_.append(K.index(t))
        
        if self.model:
            cs = s.copy()
            for i in range(len(s)):
                s[i] = cs.index(i)

            cs_ = s_.copy()
            for i in range(len(s_)):
                s_[i] = cs_.index(i)

        txt = '';j = -len(K)
        for i in range(len(MC)//len(K) * len(K)):           # 加解密
            if i % len(K) == 0:
                j += len(K)
            txt += MC[s[i-j]+j]

        for i in range(len(s_)):
            txt += MC[s_[i]+len(MC)//len(K) * len(K)]
#=====================================加解密结束===========================================
        self.mc.delete(0.0,"end")                         # 清空
        self.mc.insert("end",txt)

    def become(self):
        self.win.iconbitmap("nike.ico")                  # 设置图标
        self.win.geometry("500x200")                     # 设置窗口尺寸
        self.win.title("置换密码")                        # 设置标题
        
        ft = tkFont.Font(family='Fixdsys', size=10) 
        self.MC = tk.Entry(self.win, width = 50, font = ft)             # 明密文输入框             
        self.MC.place(relx=0.2, rely=0.1, y=3)
        self.K = tk.Entry(self.win, width = 20)                         # 密钥输入框             
        self.K.place(relx=0.2, rely=0.4)
        self.mc = tk.Text(self.win,height = 1, width = 50, font = ft)   # 明密文输出
        self.mc.place(relx=0.2, rely=0.7, y=3)         

        self.l1 = tk.Label(self.win, text="明(密)文:") 
        self.l1.place(relx=0.05, rely=0.1)
        self.l2 = tk.Label(self.win, text="密钥:")  
        self.l2.place(relx=0.07, rely=0.4)
        self.l3 = tk.Label(self.win, text="加(解)密结果:") 
        self.l3.place(relx=0.03, rely=0.7)

        self.b1 = tk.Button(self.win, text="加密", width = 8, command=self.encrypt) # 加密按钮
        self.b1.place(relx=0.55, rely=0.4, y=-5)
        self.b2 = tk.Button(self.win, text="解密", width = 8, command=self.decode)  # 解密按钮
        self.b2.place(relx=0.75, rely=0.4, y=-5) 


    def show(self):                                                                 # 展示
        self.win.mainloop()


ce = classical_encryption()
ce.become()
ce.show()