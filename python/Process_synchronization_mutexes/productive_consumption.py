# 生产消费者问题
import threading
from threading import Thread
from threading import Lock
import time

num = 0       #剩余产品数目 
num_p = 0     #已生产数量
num_c = 0     #一消耗数量
repertory = 1 #库存
lock1 = Lock()#消耗锁
lock2 = Lock()#生产锁

# 生产铲平
def productive():
    global num,repertory,num_p,num_c

    lock2.acquire() #生产锁上锁
    num = num + 1
    num_p = num_p + 1

    t = num_p - num_c
    if t != 0 and t != 1:
        print("%d,%d"%(num_p,num_c))

    lock1.release() #消耗锁解锁

    t_p = Thread(target=productive)  #生产者线程
    t_p.start()

# 消费产品
def consumption():
    global num,num_p,num_c

    lock1.acquire() #消耗锁上锁
    num = num - 1
    num_c = num_c + 1

    t = num_p - num_c
    if t != 0 and t != 1:
        print("%d,%d"%(num_p,num_c))

    lock2.release() #生产锁解锁

    t_c = Thread(target=consumption) #消费者进程
    t_c.start()

if __name__ == '__main__':
    lock1.acquire()
    t_p1 = Thread(target=productive)  #生产者线程
    t_p1.start()
    
    t_c = Thread(target=consumption) #消费者进程
    t_c.start()