# ��ӡ쳲���������

def Fibonacci(n):
    if n < 1:
        print('n�������0 ��')
        return 0
    t1 = 0
    t2 = 1
    
    while True:
        n = n -1
        if n < 1:
            return t2
        t = t1 + t2
        t1 = t2
        t2 = t


if __name__ == "__main__":
    n = int(input('������n::'))
    f = Fibonacci(n)
    if f > 0:
        print('��%d��쳲�����������:%d'%(n,f))

	##��������
	a = 12.341
	b = 2.53e10
	c = 534.23E23
	a += b
	c **= 2
	a /= b
	if a < b:
		b = 1
	elif c < b
		c = 3
	else
		c //= 2

	s = 'afewfewfefwe'
	ss = "efewfwe"
	a = b //c +242/a**b