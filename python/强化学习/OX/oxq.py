import tkinter as tk
import numpy as np
from PIL import Image,ImageTk



class OX(tk.Tk):
    def __init__(self):
        super(OX, self).__init__()
        self.n_actions = 9
        self.n_features = 9
        self.title('OX棋')
        self.iconbitmap("pic/tb.ico")
        self.maxsize(338,338)
        self.minsize(338,338)

        self.canvas = tk.Canvas(self, bg='white', height=338, width=338)
        

        image = Image.open("pic/qp.png")
        self.qp = ImageTk.PhotoImage(image) 
        self.canvas.create_image(169,169,image = self.qp) 

        image = Image.open("pic/O.png")
        self.O = ImageTk.PhotoImage(image) 

        image = Image.open("pic/X.png")
        self.X = ImageTk.PhotoImage(image) 

        self.T = self.canvas.create_text(169, 7, text = 'O:0 X:0 P:0')

        self.A = []

        self.num_O = 0
        self.num_X = 0
        self.num_P = 0

        # self.A.append(self.canvas.create_image(168,169,image = self.O))

        self.canvas.pack()
        self.update()

    def reset(self):

        while len(self.A) > 0:
            self.canvas.delete(self.A.pop())
            self.update()
        
        self.observation = [0]*9
        return np.array(self.observation.copy())
        

    def isWin(self,action,q):
        '''
        012
        345
        678
        '''
        if action == 0 and (\
            self.observation[1] + self.observation[2] == q+q or \
            self.observation[3] + self.observation[6] == q+q or \
            self.observation[4] + self.observation[8] == q+q):
            return True

        if action == 2 and (\
            self.observation[0] + self.observation[1] == q+q or \
            self.observation[5] + self.observation[8] == q+q or \
            self.observation[4] + self.observation[6] == q+q):
            return True 

        if action == 6 and (\
            self.observation[0] + self.observation[3] == q+q or \
            self.observation[2] + self.observation[4] == q+q or \
            self.observation[7] + self.observation[8] == q+q):
            return True

        if action == 8 and (\
            self.observation[2] + self.observation[5] == q+q or \
            self.observation[6] + self.observation[7] == q+q or \
            self.observation[0] + self.observation[4] == q+q):
            return True

        if action == 4 and (\
            self.observation[0] + self.observation[8] == q+q or \
            self.observation[2] + self.observation[6] == q+q or \
            self.observation[1] + self.observation[7] == q+q or \
            self.observation[3] + self.observation[5] == q+q):
            return True

        if action == 3 and (\
            self.observation[0] + self.observation[6] == q+q or \
            self.observation[4] + self.observation[5] == q+q):
            return True

        if action == 5 and (\
            self.observation[2] + self.observation[8] == q+q or \
            self.observation[3] + self.observation[4] == q+q):
            return True

        if action == 1 and (\
            self.observation[0] + self.observation[2] == q+q or \
            self.observation[4] + self.observation[7] == q+q):
            return True

        if action == 7 and (\
            self.observation[1] + self.observation[4] == q+q or \
            self.observation[6] + self.observation[8] == q+q):
            return True

        return False

    # 下棋
    def chess(self, action, q):
        if q == 'O':
            self.A.append(self.canvas.create_image(action % 3 * 112 + 56,action // 3 * 112 + 56,image = self.O))
        else:
            self.A.append(self.canvas.create_image(action % 3 * 112 + 56,action // 3 * 112 + 56,image = self.X))

    def step(self, action, q):
        if self.observation[action] == 0:
            if q == 'O':
                self.observation[action] = -1
                done = self.isWin(action,-1)
            else:
                self.observation[action] = 1
                done = self.isWin(action,1)
            self.chess(action,q)
            self.update()
            if done:
                done = True
                reward = 1
                info = 'win'
                if q == 'O':
                    self.num_O += 1
                else:
                    self.num_X += 1
            elif len(self.A) == 9:
                done = True
                reward = 0
                info = 'stalemate'
                self.num_P += 1
            else:
                reward = 0
                info = 'continue'
        else:
            reward = -1
            done = False
            info = 'error'
        

        self.canvas.itemconfig(self.T,text = 'O:'+str(self.num_O)+' X:'+str(self.num_X)+' P:'+str(self.num_P))
        self.update()

        return np.array(self.observation.copy()), reward, done, info
        