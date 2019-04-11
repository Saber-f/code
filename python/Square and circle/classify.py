import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

def draw(A,n):
    t = np.array(A.values[n][1:-1]).reshape((40,40))
    f = A.values[n][-1]
    print(f)
    plt.imshow(t, cmap = plt.cm.gray_r)
    plt.show()




train = pd.read_csv('train.csv')
test = pd.read_csv('test.csv') 

while True:
    n = int(input('n = '))
    draw(train,n)


a = 1