from oxq import OX
from qLearning import QL
from time import sleep,time

def update(env,RLO,RLX):
    first = 'X'
    # RLO.load('OX.pickle')
    t1 = time()
    for episode in range(10000):
        observatation = env.reset()

        who = first
        if first == 'O':
            first = 'X'
        else:
            first = 'O'

        while True:
            if who == 'O':
                action = RL.choose_action(''.join(observatation))
                observatation_, reward, done, info = env.step(action, who)
                RL.learn(''.join(observatation),action,reward,''.join(observatation_))
                if not info == 'error' and not done:
                    o,a,o_ = observatation,action,observatation_
                    who = 'X'
            else:
                action = RLX.choose_action(''.join(observatation))
                observatation_, reward, done, info = env.step(action, who)
                RLX.learn(''.join(observatation),action,reward,''.join(observatation_))
                if not info == 'error' and not done:
                    o,a,o_ = observatation,action,observatation_
                    who = 'O'
            if done:
                RL.learn(''.join(o),a,-1,''.join(o_))
                break
            observatation = observatation_
            

        if episode > 0 and episode % 1000 == 0:
            print(episode,'   ',time()-t1)
            RLO.save('OX.pickle')

    RLO.save('OX.pickle')
    print(10000,'   ',time()-t1)



if __name__ == "__main__":
    env = OX()
    RL = QL(list(range(9)),0.01,0.9,0.9,1)
    update(env,RL)
    env.mainloop()