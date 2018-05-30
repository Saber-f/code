'''DES加密算法'''
from numpy import *
from tkinter import *
import tkinter.font as tkFont  

'''相关置换矩阵导入'''
def DATA():
    # 明(密)文IP置换矩阵
    t = [58, 60, 62, 64, 57, 59, 61, 63]
    i = 0
    IP = []
    while i < 64:
        if i % 8 == 0:
            IP.append(t[int(i/8)])
        else:
            IP.append(IP[i-1] - 8)
        i += 1
    del t
    # 明()IP逆置换矩阵
    IP_I = [40, 8, 48, 16, 56, 24, 64, 32]
    i = 8
    while i < 64:
        IP_I.append(IP_I[i-8] - 1)
        i += 1
    # 循环左移前64->56密钥置换矩阵(去除就校验位)
    PC_1 = [57, 49, 41, 33, 25, 17, 9 ,\
            1, 58, 50, 42, 34, 26, 18,\
            10,  2, 59, 51, 43, 35, 27,\
            19, 11,  3, 60, 52, 44, 36,\
            63, 55, 47, 39, 31, 23, 15,\
            7, 62, 54, 46, 38, 30, 22,\
            14,  6, 61, 53, 45, 37, 29,\
            21, 13,  5, 28, 20, 12, 4]
    # 循环左移后56->48密钥置换矩阵(得到每轮的密钥)
    PC_2 = [14, 17, 11, 24,  1,  5,\
            3, 28, 15,  6, 21, 10,\
            23, 19, 12,  4, 26,  8,\
            16,  7, 27, 20, 13,  2,\
            41, 52, 31, 37, 47, 55,\
            30, 40, 51, 45, 33, 48,\
            44, 49, 39, 56, 34, 53,\
            46, 42, 50, 36, 29, 32]
    # E盒(32位明(密)文扩展为48位)
    E = [32,  1,  2,  3,  4, 5,\
         4,  5,  6,  7,  8, 9,\
         8,  9, 10, 11, 12, 13,\
         12, 13, 14, 15, 16, 17,\
         16, 17, 18, 19, 20, 21,\
         20, 21, 22, 23, 24, 25,\
         24, 25, 26, 27, 28, 29,\
         28, 29, 30, 31, 32, 1]
    # S盒
    S_BOX = []
    S_BOX.append(mat('\
                     14 4 13 1 2 15 11 8 3 10 6 12 5 9 0 7;\
                     0 15 7 4 14 2 13 1 10 6 12 11 9 5 3 8;\
                     4 1 14 8 13 6 2 11 15 12 9 7 3 10 5 0;\
                     15 12 8 2 4 9 1 7 5 11 3 14 10 0 6 13'))
    S_BOX.append(mat('\
                     15 1 8 14 6 11 3 4 9 7 2 13 12 0 5 10;\
                     3 13 4 7 15 2 8 14 12 0 1 10 6 9 11 5;\
                     0 14 7 11 10 4 13 1 5 8 12 6 9 3 2 15;\
                     13 8 10 1 3 15 4 2 11 6 7 12 0 5 14 9'))
    S_BOX.append(mat('\
                     10 0 9 14 6 3 15 5 1 13 12 7 11 4 2 8;\
                     13 7 0 9 3 4 6 10 2 8 5 14 12 11 15 1;\
                     13 6 4 9 8 15 3 0 11 1 2 12 5 10 14 7;\
                     1 10 13 0 6 9 8 7 4 15 14 3 11 5 2 12'))
    S_BOX.append(mat('\
                     7 13 14 3 0 6 9 10 1 2 8 5 11 12 4 15;\
                     13 8 11 5 6 15 0 3 4 7 2 12 1 10 14 9;\
                     10 6 9 0 12 11 7 13 15 1 3 14 5 2 8 4;\
                     3 15 0 6 10 1 13 8 9 4 5 11 12 7 2 14'))
    S_BOX.append(mat('\
                     2 12 4 1 7 10 11 6 8 5 3 15 13 0 14 9;\
                     14 11 2 12 4 7 13 1 5 0 15 10 3 9 8 6;\
                     4 2 1 11 10 13 7 8 15 9 12 5 6 3 0 14;\
                     11 8 12 7 1 14 2 13 6 15 0 9 10 4 5 3'))
    S_BOX.append(mat('\
                     12 1 10 15 9 2 6 8 0 13 3 4 14 7 5 11;\
                     10 15 4 2 7 12 9 5 6 1 13 14 0 11 3 8;\
                     9 14 15 5 2 8 12 3 7 0 4 10 1 13 11 6;\
                     4 3 2 12 9 5 15 10 11 14 1 7 6 0 8 13'))
    S_BOX.append(mat('\
                     4 11 2 14 15 0 8 13 3 12 9 7 5 10 6 1;\
                     13 0 11 7 4 9 1 10 14 3 5 12 2 15 8 6;\
                     1 4 11 13 12 3 7 14 10 15 6 8 0 5 9 2;\
                     6 11 13 8 1 4 10 7 9 5 0 15 14 2 3 12'))
    S_BOX.append(mat('\
                     13 2 8 4 6 15 11 1 10 9 3 14 5 0 12 7;\
                     1 15 13 8 10 3 7 4 12 5 6 11 0 14 9 2;\
                     7 11 4 1 9 12 14 2 0 6 10 13 15 3 5 8;\
                     2 1 14 7 4 10 8 13 15 12 9 0 3 5 6 11'))
    P = [16,  7, 20, 21,\
         29, 12, 28, 17,\
         1, 15, 23, 26,\
         5, 18, 31, 10,\
         2,  8, 24, 14,\
         32, 27,  3,  9,\
         19, 13, 30,  6,\
         22, 11,  4, 25]
    return (IP,IP_I,PC_1,PC_2,E,S_BOX,P)
(IP,IP_I,PC_1,PC_2,E,S_BOX,P) = DATA()

'''置换函数(D为置换数据,E为置换矩阵)'''
def replace(D,E):
    L = []
    R = []
    i = 0
    while i < len(E)/2:
        L.append(D[E[i]-1])
        i += 1
    while i < len(E):
        R.append(D[E[i]-1])
        i += 1
    return (L,R)

'''异或运算'''
def list_xor(l1,l2):
    i = 0
    L = []
    while i < len(l1):
        if l1[i] == l2[i]:
            L.append('0')
        else:
            L.append('1')
        i += 1
    return L

'''S盒处理(D为6*8数据)'''
def S_box_dispose(D,S):
    i = 0 # D角标
    result = [] # 结果
    while i < len(D)/6:
        x = 0 # S盒x坐标
        y = 0 # S盒y坐标
        if D[int(i*6)] == '1':
            x += 2
        if D[int(i*6+1)] == '1':
            y += 8
        if D[int(i*6+2)] == '1':
            y += 4
        if D[int(i*6+3)] == '1':
            y += 2
        if D[int(i*6+4)] == '1':
            y += 1
        if D[int(i*6+5)] == '1':
            x += 1
        t = S[i][x,y]
        j = 8
        while j > 0.5:
            if t > j - 1:
                result.append('1')
                t -= j
            else:
                result.append('0')
            j /= 2
        i += 1
    return result

'''循环左右移(M为True为左移)'''
def list_move(C,D,M):
    if M:
        return (C[1:len(C)]+[C[0]],D[1:len(D)]+[D[0]])
    else:
        return ([C[len(C)-1]]+C[0:len(C)-1],[D[len(D)-1]]+D[0:len(D)-1])

'''打印字符列表(L为字符列表,n为一组的数目)'''
def print_str_list(L,n):
    i = 1
    for c in L:
        print(c,end = '')
        if n != 0 and i%n == 0:
            print(end=' ')
        i += 1

'''DES加(解)密函数(MC为明文或密文,KEY为密钥,MODE为True(False)为加(解)密)'''
def DES(MC,KEY,MODE):
    (Li,Ri) = replace(MC,IP)         # IP置换得到L0,R0
    (Ci,Di) = replace(KEY,PC_1)      # 得到初始子密钥C0,D0
    Li_ = Ri
    # 16轮循环加(解)密
    if MODE:
        i = 1
    else:
        i = 16
    while (i <= 16 and MODE) or (i > 0 and not MODE):
        # 循环左移
        if MODE:
            (Ci,Di) = list_move(Ci,Di,MODE)
            if i != 1 and i != 2 and i != 9 and i != 16:
                (Ci,Di) = list_move(Ci,Di,MODE)
        # 通过PC_2将循环左移后的56位密钥压缩得要48位子密钥
        (t1,t2) = replace(Ci+Di,PC_2)
        Ki = t1+t2
        # 通过E盒将32位Ri明(密)文扩展为48位
        (t1,t2) = replace(Ri,E)
        Ri = t1+t2
        # Ki,Ri亦或
        Ri = list_xor(Ki,Ri)
        # 通过S盒将异或结果加密输出
        Ri = S_box_dispose(Ri,S_BOX)
        # P盒置换
        (t1,t2) = replace(Ri,P)
        Ri = t1+t2
        # P盒子置换结果与Li异或运算
        Ri = list_xor(Li,Ri)
        # 左右交换位置
        Li = Li_
        Li_ = Ri
        # 循环右移
        if not MODE:
            (Ci,Di) = list_move(Ci,Di,MODE)
            if i != 1 and i != 2 and i != 9 and i != 16:
                (Ci,Di) = list_move(Ci,Di,MODE)
        if MODE:
            i += 1
        else:
            i -= 1
    (t1,t2) = replace(Ri+Li,IP_I)
    return t1+t2

'''主函数'''
#明文::0011100011010101101110000100001011010101001110011001010111100111
#密钥::1010101100110100100001101001010011011001011100111010001011010011
#    RESULT = DES(M[0],Key,True)
#    print_str_list(RESULT,8)




class wins:
    def __init__(self):
        self.win = Tk()
        self.win.iconbitmap("nike.ico")                  # 设置图标
        self.win.geometry("500x200")                     # 设置窗口尺寸
        self.win.title("DES")                        # 设置标题
        
        ft = tkFont.Font(family='Fixdsys', size=10) 
        self.MC = Entry(self.win, width = 50, font = ft)             # 明密文输入框             
        self.MC.place(relx=0.2, rely=0.1, y=3)
        self.K = Entry(self.win, width = 50, font = ft)              # 密钥输入框             
        self.K.place(relx=0.2, rely=0.3, y=3)
        self.mc = Text(self.win,height = 1, width = 50, font = ft)   # 明密文输出
        self.mc.place(relx=0.2, rely=0.5, y=3)         

        self.l1 = Label(self.win, text="明(密)文:") 
        self.l1.place(relx=0.05, rely=0.1)
        self.l2 = Label(self.win, text="密钥:")  
        self.l2.place(relx=0.07, rely=0.3)
        self.l3 = Label(self.win, text="加(解)密结果:") 
        self.l3.place(relx=0.03, rely=0.5)

        self.b1 = Button(self.win, text="加密", width = 8, command=self.encrypt) # 加密按钮
        self.b1.place(relx=0.3, rely=0.7)
        self.b2 = Button(self.win, text="解密", width = 8, command=self.decode)  # 解密按钮
        self.b2.place(relx=0.6, rely=0.7) 

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
#=====================================加解密开始===========================================
        txt = "hello"
#=====================================加解密结束===========================================
        self.mc.delete(0.0,"end")                         # 清空
        self.mc.insert("end",txt)

    def show(self):
        self.win.mainloop()


W = wins()
W.show()
    
