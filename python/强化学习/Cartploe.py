import gym
from time import sleep
env = gym.make('CartPole-v1')

observation = env.reset()

score = 0

for t in range(10000):
    env.render()
    sleep(0.001)

    print(observation)

    if observation[2] + 0.6*(observation[3] - observation[1]) + 0.3*observation[0]> 0:
        action = 1
    else:
        action = 0

    observation, reward, done, info = env.step(action)
    score += reward
    if done:
        print('score = ',score)
        break
env.close()