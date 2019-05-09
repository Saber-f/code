import gym
from time import sleep
env = gym.make('CartPole-v1')

observation = env.reset()

score = 0

for t in range(100):
    env.render()
    sleep(0.1)
    action = int(input('action = '))
    observation, reward, done, info = env.step(action)
    score += reward
    if done:
        print('score = ',score)
        break
env.close()