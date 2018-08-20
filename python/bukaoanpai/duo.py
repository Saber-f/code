import time
from multiprocessing import Process,Pipe

def f(conn):
    conn.send([42,None,'hello'])
    conn,close()

if __name__ == '__main__':
    parent_conn, child_conn = Pipe()
    th = Process(target=f,args=(child_conn,))
    th.start()
    print(parent_conn.recv())
    th.join()
    
