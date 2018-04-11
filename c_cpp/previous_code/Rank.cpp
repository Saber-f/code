//此程序为快速排序,有树排序和冒泡排序的比较
#include<iostream>/*{{{*/
#include<time.h>
#include<stdlib.h>

using namespace std;/*}}}*/

class stack/*{{{*/
{
private:
	typedef struct node
	{
		int data;
		struct node *next;
	}NODE;
	NODE *S;
	int n;

public:
	stack()//定义构造函数
	{
		n = 0;
		S = NULL;
	}

	~stack()//定义析构函数
	{
		NODE *p;
		while (S)
		{
			p = S->next;
			delete(S);
			n--;
			S = p;
		}
	}

	void push(int data)//定义入栈函数
	{
		NODE *p = new NODE[1];
		p->data = data;
		p->next = S;
		S = p;
		n++;
	}

	int pop()//定义出栈函数
	{
		int data;
		if (!S)
		{
			cout << "nothing !" << endl;
			exit(-1);
		}
		data = S->data;
		S = S->next;
		n--;
		return data;
	}

	int getn()//返回n
	{
		return n;
	}
};/*}}}*/

class fast /*{{{*/
{
public:
	int rankmiddle(int *A, int n1, int n2)//比A[1]小的排左边，大的排右边
	{
		int middle = A[n1];
		while (n1 < n2)
		{
			while (n1 < n2)
			{
				if (A[n2] < middle)
				{
					A[n1] = A[n2];
					n1++;
					break;
				}
				n2--;

			}

			while (n1 < n2)
			{
				if (A[n1] > middle)
				{
					A[n2] = A[n1];
					break;
				}
				n1++;
			}
		}
		A[n1] = middle;
		return n1;
	}

	void rankfast(int *A, int n1, int n2)//对A进行快速排序
	{
		int n;
		if (n1 < n2)
		{
			n = rankmiddle(A, n1, n2);
			rankfast(A, n1, n - 1);
			rankfast(A, n + 1, n2);
		}
	}
};/*}}}*/

class ranktree/*{{{*/
{
private:/*{{{*/
	typedef struct node
	{
		int data;
		struct node *next[2];
	}NODE;

	int *cnp, ii;
	NODE *T, *pT;/*}}}*/

public:
	ranktree()//define a constructors{{{
	{
		pT = T = NULL;
	}/*}}}*/

	~ranktree()//define a destructor{{{
	{
		initialize_pT();
		destroy();
	}/*}}}*/

	void rankpush(int n)//add the n order in the tree {{{
	{
		NODE *p = new NODE[1], *pt;
		p->data = n;
		p->next[0] = p->next[1] = NULL;
		if (!T)
		{
			T = p;
			return;
		}

		pt = T;
		while (true)
		{
			if (n < pt->data)
			{
				if (pt->next[0] == NULL)
				{
					pt->next[0] = p;
					break;
				}
				else
					pt = pt->next[0];
			}
			else
			{
				if (pt->next[1] == NULL)
				{
					pt->next[1] = p;
					break;
				}
				else
					pt = pt->next[1];
			}
		}
	}/*}}}*/

	void tree(int *np)// {{{
	{
		for (int i = 1; i <= np[0]; i++)
			rankpush(np[i]);
		initialize_pT();
		cnp = np;
		ii = 1;
		mid();
		initialize_pT();
		destroy();
	}/*}}}*/

	void initialize_pT()/*{{{*/
	{
		pT = T;
	}/*}}}*/

	void mid()//rank {{{
	{
		NODE *p;
		if (!pT)
			return;
		p = pT;
		pT = p->next[0];
		mid();
		cnp[ii++] = p->data;
		pT = p->next[1];
		mid();
	}	/*}}}*/

	void destroy()//destroy tree {{{
	{
		NODE *p;
		if (!T)
			return;
		p = T;
		//postorder traversal
		T = p->next[0];
		destroy();
		T = p->next[1];
		destroy();
		delete(p);

		//inorder traversal
		/*
		T = p->next[0];
		destroy();
		delete(p);
		T = p->next[1];
		destroy();
		*/

		//preorder traversal*
		/*
		delete(p);
		T = p->next[0];
		destroy();
		T = p->next[1];
		destroy();
		*/
	}/*}}}*/
};/*}}}*/

int *inputA()//定义输入函数{{{
{
	int *A, data;
	stack S;
	char c = 0;
	while (c != 10)
	{
		cin >> data;
		S.push(data);
		c = getchar();
	}

	A = new int[S.getn() + 1];
	A[0] = S.getn();

	for (int i = 1; i <= A[0]; i++)
		A[i] = S.pop();

	return A;
}/*}}}*/

void bubble(int *A)//用冒泡算法对A进行排序{{{
{
	bool b = true;
	for (int i = 1; b && (i < A[0]); i++)
	{
		b = false;
		for (int j = A[0]; j > i; j--)
			if (A[j] < A[j - 1])
				A[j] ^= A[j - 1], A[j - 1] ^= A[j], A[j] ^= A[j - 1], b = true;
	}
}/*}}}*/

void productA(int *&A)//产生n个随机整数数组{{{
{
	srand((unsigned)time(NULL));//设置种子
	for (int i = 1; i <= A[0]; i++)
		A[i] = rand() % 100;
}/*}}}*/

void copy(int *A, int *B)//复制数组A{{{
{
	for (int i = 0; i <= A[0]; i++)
		B[i] = A[i];
}/*}}}*/

void printA(int *A)//打印A{{{
{
	for (int i = 1; i <= A[0]; i++)
		cout << A[i] << " ";
	cout << endl;
}/*}}}*/

int main(void)/*{{{*/
{
	ranktree rt;
	int size,M,N;
	M = 60;
	N = 1000;
	clock_t t1, t2;
	double tf, tb, tc;
	fast F;
	int *C, *B, *A;
	for (int i = 1; i < M; i++)
	{
		size = i * 10;
		tf = tb = tc = 0;
		A = new int[size + 1];
		A[0] = size;

		B = new int[size + 1];
		C = new int[size + 1];

		for (int j = 0; j < N; j++)
		{
			productA(A);
			copy(A, B);
			copy(A, C);

			t1 = clock();
			F.rankfast(A, 1, A[0]);
			t2 = clock();
			tf += (t2 - t1);

			t1 = clock();
			rt.tree(B);
			t2 = clock();
			tb += (t2 - t1);

			t1 = clock();
			bubble(C);
			t2 = clock();
			tc += (t2 - t1);
		}
		delete(A); delete(B); delete(C);
		tf /= N;
		tb /= N;
		tc /= N;
		cout << tf << " " << tb << " " << tc << endl;
	}
	getchar();
	return 0;
}/*}}}*/
