#include <iostream>

using namespace std;

class FastSort
{
	typedef struct node
	{
		int data;
		struct node *last,*next;
	}NODE;

	NODE *H,*T;

public:
	FastSort()//构造函数
	{
		H = NULL;
	}
	
	~FastSort()//析构
	{
		NODE *p;
		while (H)
		{
			p = H->next;
			delete(H);
			H = p;
		}
	}

	void Push(NODE *&H,int data)//入栈
	{
		NODE *p;
		if (!H)
		{
			H = new NODE;
			H->data = data;
			H->next = NULL;
			H->last = NULL;
			T = H;
			return;
		}
		p = new NODE;
		p->data = data;
		p->next = NULL;
		p->last = T;
		T->next = p;
		T = p;
	}

	void Input()//输入数据
	{
		int data;
		char c = 0;
		while (c != 10)
		{
			cin >> data;
			Push(H,data);
			c = getchar();
		}
	}
	
	void Last(NODE *H,NODE *p)//将p放在H的左边
	{
		p->last->next = p->next;
		if (p->next)
			p->next->last = p->last;
		p->next = H;
		p->last = H->last;
		if (H->last)
			H->last->next = p;
		H->last = p;
	}

	void fast(NODE *p1, NODE *p2)//快速排序递归定义
	{
		NODE *p,*t;
		if (p1 == p2)
			return;
		p = p1->next;
		if (p == p2)
		{
			if (p->data < p1->data)
				Last(p1, p);
			return;
		}
		t = p1;
		while (true)
		{
			if (p == p2)
			{
				if (p2->data < p1->data)
				{
					p2 = p2->last;
					Last(p1, p2->next);
				}
				fast(t, p1);
				if (p1 == p2)
					return;
				fast(p1->next, p2);
				return;
			}
			p = p->next;
			if (p->last->data < p1->data)
			{
				Last(p1, p->last);
				if (t == p1)
					t = p1->last;
			}
		}
	}

	void sort()//快速排序
	{
		fast(H, T);
	}

	void output()
	{
		NODE *p = H;
		while (p->last)
			p = p->last;
		while (p)
		{
			cout << p->data << " ";
			p = p->next;
		}
		cout << endl;
	}
};

int main(void)
{
	FastSort FS;
	FS.Input();
	FS.sort();
	FS.output();
	return 0;
}
