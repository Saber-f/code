import numpy as np
import pandas as pd
import time

N_STATES = 6                    # 1维世界的宽度
ACTIONS = ['left','right']      # 探索者的可用动作
EPSILON = 0.9                   # 贪婪度 greedy
ALPHA = 0.1                     # 学习率
GAMMA = 0.9                     # 学习奖励递减值
MAX_EPISODES = 13               # 最大回合数
FRESH_TIME = 0.3                # 移动间隔时间

def build_q_table(n_states, actions):
    table = pd.DataFrame(
        np.zeros((n_states,len(actions))),  # q_table 全0的初始
        columns = actions,                  # columns 对应的是行为名称
    )
    return table
# q_table
'''
    left    right
0    0.0     0.0
1    0.0     0.0
2    0.0     0.0
3    0.0     0.0
4    0.0     0.0
5    0.0     0.0
'''

# 在某个 state 地点，选择行为
def choose_action()