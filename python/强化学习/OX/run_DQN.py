from oxq import OX
from RL_brain import DeepQNetwork
import numpy as np


def update(env,RL):
    step = 0
    first = 'O'
    for episode in range(10000):
        # initial observation
        observation = env.reset()

        who = first
        if first == 'O':
            first = 'X'
        else:
            first = 'O'

        while True:
            if who == 'O':
                action = RL.choose_action(observation)
                observation_, reward, done, info = env.step(action, who)
                RL.store_transition(observation, action, reward, observation_)
                if (step > 200) and (step % 5 == 0):
                    RL.learn()
                if not info == 'error':
                    who = 'X'
            else:
                action = RL.choose_action(observation)
                observation_, reward, done, info = env.step(action, who)
                RL.store_transition(observation, action, reward, observation_)
                if (step > 200) and (step % 5 == 0):
                    RL.learn()

                if not info == 'error':
                    who = 'O'
            if done:
                if who == 'O':  # O输了
                    RL.store_transition(o, a, -1, o_)
                else:
                    RL.store_transition(o, a, -1, o_)
                break

            step += 1

            # swap observation
            observation = observation_
            o,a,o_ = observation,action,observation_



if __name__ == "__main__":
    # maze game
    env = OX()
    RL = DeepQNetwork(env.n_actions, env.n_features,
                      learning_rate=0.01,
                      reward_decay=0.9,
                      e_greedy=0.9,
                      replace_target_iter=200,
                      memory_size=2000,
                      output_graph=True
                      )
    update(env,RL)
    RL.plot_cost()