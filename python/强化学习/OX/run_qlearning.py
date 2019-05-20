from oxq import OX
from qLearning import QL
from time import sleep,time

def update(env,RLO,RLX):
    first = 'X'
    RLO.load('O.pickle')
    RLX.load('X.pickle')
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
                action = RLO.choose_action(''.join(observatation))
                observatation_, reward, done, info = env.step(action, who)
                RLO.learn(''.join(observatation),action,reward,''.join(observatation_))
                if not info == 'error':
                    sleep(0)
                    who = 'X'
            else:
                action = RLX.choose_action(''.join(observatation))
                observatation_, reward, done, info = env.step(action, who)
                RLX.learn(''.join(observatation),action,reward,''.join(observatation_))
                if not info == 'error':
                    sleep(0)
                    who = 'O'
            if done:
                sleep(0)
                if who == 'O':  # O输了
                    RLO.learn(''.join(o),a,-1,''.join(o_))
                else:
                    RLX.learn(''.join(o),a,-1,''.join(o_))
                break
            o,a,o_ = observatation,action,observatation_
            observatation = observatation_
            

        if episode > 0 and episode % 1000 == 0:
            print(episode,'   ',time()-t1)
            RLO.save('O.pickle')
            RLO.save('X.pickle')

    RLO.save('O.pickle')
    RLO.save('X.pickle')
    print(episode,'   ',time()-t1)



if __name__ == "__main__":
    env = OX()
    RLO = QL(list(range(9)),0.01,0.9,0.9,1)
    RLX = QL(list(range(9)),0.01,0.9,0.9,1)
    update(env,RLO,RLX)
    env.mainloop()