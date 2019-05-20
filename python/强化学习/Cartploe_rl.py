import numpy as np
import pandas as pd
import time
import gym

N_STATES = 100                  # 1维世界的宽度
ACTIONS = [0,1]                 # 探索者的可用动作
EPSILON = 0.9                   # 贪婪度 greedy
ALPHA = 0.1                     # 学习率
GAMMA = 0.9                     # 学习奖励递减值
MAX_EPISODES = 1000               # 最大回合数
FRESH_TIME = 0.1                # 移动间隔时间

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
def choose_action(state,q_table):
    state_action = q_table.iloc[state,:]    # 选出这个state的所有action值
    if(np.random.uniform() > EPSILON) or (state_action.all() == 0):     # 非贪婪or或者这个state还没有探索过
        action_name = np.random.choice(ACTIONS)
    else:
        action_name = state_action.values.argmax()                             # 贪婪模式
    return action_name

def get_S(observation):
    m = int(observation[2]*100)+5
    if m < 0:
        m = 0
    elif m > 9:
        m = 9
    n = int(observation[3]-observation[1]*10)+5
    if n < 0:
        n = 0
    elif n > 9:
        n = 9
    return m*10 + n

def rl():
    q_table = build_q_table(N_STATES,ACTIONS)       # 初始化q table
    env = gym.make('CartPole-v1')                   # 游戏
    for episode in range(MAX_EPISODES):             
        observation = env.reset()                   # 初始化游戏环境
        step_counter = 0                            # 回合
        S = get_S(observation)                      # 回合初始位置
        is_terminated = False                       # 回合是否结束
        while not is_terminated:
            env.render()
            action = choose_action(S,q_table)       # 选行为
            observation, reward, done, info = env.step(action)          # 实施行为并得到环境的反馈
            S_ = get_S(observation)
            q_predict = q_table.loc[S,action]                           # 估算的(状态-行为)值
            if not done:
                q_target = reward + GAMMA * q_table.iloc[S_,:].max()    # 实际的(状态-行为)值(回合还没结束)
            else:
                q_target = -100                                         # 实际的(状态-行为)值(回合结束)
                is_terminated = True                                    # 回合结束
                print(episode,':',step_counter)

            q_table.loc[S,action] += ALPHA * (q_target - q_predict)     # q_table更新
            S = S_                                                      # 探索者移动到下一个state
            step_counter += 1
    return q_table


if __name__ == "__main__":
    q_table = rl()
    print('\r\nQ_table:\n')
    for i in range(len(q_table)):
        print(int(q_table.loc[i,0] - q_table.loc[i,1]),end = ' ')
        if i > 0 and i % 10 == 0:
            print()