import numpy as np
import pandas as pd

class QL:
    def __init__(self, actions, learning_rate=0.01, reward_decay=0.9, egreedy=1, be = 0.99):
        self.actions = actions # 包含所有可选动作
        self.learning_rate = learning_rate
        self.gama = reward_decay
        self.epsilon = egreedy
        self.be = be
        self.q_table = pd.DataFrame(columns=self.actions, dtype=np.float32)

    def choose_action(self, observation):
        if self.check_table(observation) or np.random.uniform() > self.epsilon:
            self.epsilon *= self.be
            return np.random.choice(self.actions)
        else:
            self.epsilon *= self.be
            return self.q_table.loc[observation, :].idxmax()

    def check_table(self, observation):
        if observation not in self.q_table.index:
            self.q_table = self.q_table.append(
                pd.Series(
                    [0]*len(self.actions),
                    index=self.actions,
                    name = observation
                )
            )
            return True
        return False
        

    def learn(self, observation, action, reward, observation_):
        self.check_table(observation_)
        q_predict = self.q_table.loc[observation, action]
        if observation_ == 'terminal':
            q_target = reward
        else:
            q_target = reward + self.gama * self.q_table.loc[observation_,:].max()
        self.q_table.loc[observation, action] += self.learning_rate * (q_target - q_predict)


    def save(self,name):
        self.q_table.to_pickle(name)

    def load(self,name):
        self.q_table = pd.read_pickle(name)

