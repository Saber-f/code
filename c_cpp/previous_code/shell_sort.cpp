#include<iostream>
#include<stdlib.h>

#define MAX_N 1000000000

using namespace std;

long long NN = 0;

//递归算法
int ack(int m, int n)
{
	if (m == 0)
		return n + 1;
	else if (m != 0 && n == 0)
		return ack(m - 1, 1);
	else if (m != 0 && n != 0)
		return ack(m - 1, ack(m, n - 1));
	else
		return -1;
}//递归算法

typedef struct node
{
	int data;
	struct node *next;
}NODE;

//大数运算的类
class big_num
{
public:
	//初始化得到一个大数
	NODE * get(int n)
	{
		NODE *N = new NODE;
		N->data = n;
		N->next = NULL;
		return N;
	}

	//销毁一个大数
	void destory(NODE *N)
	{
		NODE *p;//临时结构体指针变量
		while (N)
		{
			p = N;
			N = N->next;
			delete(p);
		}
	}

	//头插
	void insert_head(NODE *&N, int n)
	{
		NODE *p = new NODE;
		p->next = N;
		p->data = n;
		N = p;
	}

	//尾插
	void insert_tail(NODE *&N, int n)
	{
		NODE *p;
		if (!N)
		{
			N = new NODE;
			N->data = n;
			N->next = NULL;
			return;
		}
		p = N;
		while (p->next) p = p->next;
		p->next = new NODE;
		p = p->next;
		p->data = n;
		p->next = NULL;
	}

	//得到两个大数相加的结果
	NODE *add(NODE *N1, NODE *N2)
	{
		long long ll;//临时长整型变量
		int n1, n2 = 0;
		NODE *N = NULL;
		while (N1 || N2)
		{
			if (N1 && N2)
				ll = (long long)N1->data + N2->data + n2;
			else if (N1)
				ll = (long long)N1->data + n2;
			else
				ll = (long long)N2->data + n2;
			n1 = (int)(ll % MAX_N);
			insert_head(N, n1 + n2);
			n2 = (int)(ll / MAX_N);
			if (N1)
				N1 = N1->next;
			if (N2)
				N2 = N2->next;
		}
		return N;
	}

	//一个大数加一个小数
	NODE *sum_int(NODE *N, int n)
	{
		NODE *p;
		p = N;
		while (p->data >= MAX_N - n)
		{
			if (p->next != NULL)
			{
				p->data = 0;
				n = ((long long)MAX_N + n) % MAX_N;
				p = p->next;
			}
			else
			{
				insert_tail(p, 0);
				p = p->next;
				break;
			}
		}
		p->data += n;
		return N;
	}

	//一个大数减一个小数
	NODE *sub_int(NODE *N, int n)
	{
		NODE *p;
		p = N;
		while (p->data < n)
		{
			if (p->next != NULL)
			{
				p->data = MAX_N - (n - p->data);
				n = 1;
				p = p->next;
			}
		}
		p->data -= n;
		return N;
	}

	//一个大数乘上一个小数
	NODE *mult_int(NODE *N, int n)
	{
		long long ll;
		int n1 = 0;//n1 为进位数
		NODE *p;
		p = N;
		while (true)
		{
			ll = ((long long)p->data * n) + n1;
			p->data = ll % MAX_N;
			n1 = (int)(ll / MAX_N);
			if (p->next == NULL)
			{
				if (n1)
				{
					p->next = new NODE;
					p->next->data = n1;
					p->next->next = NULL;
				}
				break;
			}
			p = p->next;
		}
		return N;
	}

	//m^n
	NODE *power(int m, int n)
	{
		NODE *N;
		if (n == 0)
			N = get(1);
		else
		{
			N = get(m);
			for (int i = 0; i < n - 1; i++)
				N = mult_int(N, m);
		}
		return N;
	}

	//打印出结果
	void display(NODE *N)
	{
		NODE *p = NULL;
		while (N)
		{
			insert_head(p, N->data);
			N = N->next;
		}
		cout << p->data;
		p = p->next;
		while (p)
		{
			printf("%09d", p->data);
			p = p->next;
		}
		cout << endl;
	}
};

//数据结构期末考试递归题的大数非递归算法
class class_ack
{
public:
	//非递归运算辅助栈的节点定义
	typedef struct stack
	{
		int m;
		NODE *n;
		struct stack *next;
	}STACK;

	//入栈
	void push(STACK *&S, int m, NODE *n)
	{
		STACK *p = new STACK;
		p->m = m;
		p->n = n;
		p->next = S;
		S = p;
		NN++;
	}

	//出栈
	void pop(STACK *&S)
	{
		STACK *p = S;
		S = S->next;
		delete(p);
		NN--;
	}

	//m = 4展示
	void disack4n(int n)
	{
		for (int i = 1; i < n; i++)
			cout << "2^((";
		cout << "2^13-3";
		for (int i = 1; i < n; i++)
			cout << ")+3)-3";
		cout << endl;
	}

	//非递归算法
	void ack(int m, int n)
	{
		big_num BN;
		NODE *val = NULL;
		STACK *S = NULL;
		push(S, m, BN.get(n));
		while (S)
		{
			if (S->n == NULL)
			{
				S->n = val;
				val = NULL;
			}
			else if (S->m == 0)//m = 0
			{
				val = BN.sum_int(S->n, 1);
				pop(S);
			}
			else if (S->n->data == 0 && S->n->next == NULL)//n = 0
			{
				S->m--;
				S->n->data = 1;
			}

			//加速运算
			else if (S->m == 1)//当m = 1;val = n + 2
			{
				val = BN.sum_int(S->n, 2);
				pop(S);
			}
			else if (S->m == 2)//当m = 2;val = 2n + 3
			{
				val = BN.add(S->n, S->n);
				BN.destory(S->n);
				val = BN.sum_int(val, 3);
				pop(S);
			}
			else if (S->m == 3)//当m = 3;val = 2^(n+3) - 8 + 5
			{
				if (S->n->next)
				{
					cout << "too big" << endl;
					getchar();
					return;
				}
				val = BN.sub_int(BN.power(2, S->n->data + 3), 3);
				pop(S);
			}

			else if (S->m == 4 && S->n->data > 2)//当m = 4;(4 0) = (3 1) = (2^(1+3) - 3),2^((2^(1+3) - 3) + 3) - 3
			{
				if (S->n->next)
				{
					cout << "too big" << endl;
					getchar();
					return;
				}
				disack4n(S->n->data);
				return;
			}

			//加速运算结束
			else
			{
				//S->n减一
				push(S, S->m, S->n);
				S->n = BN.sub_int(S->n, 1);
				S->next->m--;
				S->next->n = NULL;
			}
		}
		BN.display(val);
	}
};

//主函数
int main(void)
{
	class_ack ack1;
	int m, n, z;
	do {
		scanf_s("%d %d", &m, &n);
		z = m / n;
		ack1.ack(m, n);
	} while (m != 0 || n != 0);
	system("pause");
	return 0;
}
