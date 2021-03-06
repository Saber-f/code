// Graph_operation.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>

using namespace std;

class Graph
{
private:
	struct node;//声明结构体

	typedef struct edge
	{
		struct node *data;
		struct edge *next;
	}EDGE;

	typedef struct node
	{
		bool flage;
		int n;//点编号
		EDGE *next;//表示指向下一个节点的变得集合的栈
	}NODE;

	typedef struct two_node
	{
		NODE *p1, *p2;
	}TWO_NODE;

	EDGE *G;
		
public:
	Graph()//定义构造函数
	{
		G = NULL;
	}

	~Graph()//定义析构函数
	{



	}

	NODE *HaveNode(NODE *p, int n,bool b)//包含p节点的图中有编号为n的节点吗？
	{
		EDGE *pe;
		NODE *rp,*t;
		rp = NULL;
		if (p->flage != b) return NULL;
		p->flage = !b;
		pe = p->next;
		while (pe)
		{
			t = HaveNode(pe->data, n, b);
			if (t)
				rp = t;
			pe = pe->next;
		}
		if (rp)
			return rp;
		if (p->n == n)
			return p;
		return NULL;
	}

	TWO_NODE IsWhere(int n)//编号为n的节点在已存在的图中吗？
	{
		NODE *t;
		EDGE *p;
		TWO_NODE tn;
		tn.p1 = tn.p2 = NULL;
		p = G;
		while (p)
		{
			t = HaveNode(p->data,n,p->data->flage);
			if (t)
			{
				tn.p1 = t;
				tn.p2 = p->data;
			}
			p = p->next;
		}
		return tn;
	}

	void PushEdge(EDGE *&pe,NODE *data)//边入栈
	{
		EDGE *p;
		p = new EDGE;
		p->data = data;
		p->next = pe;
		pe = p;
	}

	void PopEdge(EDGE *G, NODE *p)//顶点p从链表G中删除但不释放
	{
		EDGE *t;
		if (G->data == p)
		{
			G = G->next;
			return;
		}
		t = G;
		while (t -> next)
		{
			if (t->next->data == p)
			{
				t->next = t->next->next;
				return;
			}
		}
	}

	bool HaveRelevance(NODE *p1, NODE *p2)//判断两个点有没有联系
	{
		EDGE *p;
		p = p1->next;
		while (p)
		{
			if (p->data == p2)
				return true;
			p = p->next;
		}
		return false;
	}

	void Contact(NODE *p1, NODE *p2)//联系两个点
	{
		PushEdge(p1->next, p2);
		PushEdge(p2->next, p1);
	}

	NODE *NewNODE(int n, bool b)//创建新节点
	{
		NODE *p;
		p = new NODE;
		p->flage = b;
		p->n = n;
		p->next = NULL;
		return p;
	}

	void Create(int n1, int n2)//在图中添加编号为n1和n2点联系
	{
		bool b;
		NODE *p1, *p2;
		TWO_NODE tn1,tn2;
		tn1 = IsWhere(n1);
		tn2 = IsWhere(n2);
		if (G)
			b = G->data->flage;
		else
			b = true;
		if (tn1.p1 && tn2.p1)//两个点均在图中
		{
			if (HaveRelevance(tn1.p1, tn2.p1))
				return;
			else
			{
				Contact(tn1.p1, tn2.p1);
				if (tn1.p2 != tn2.p2)
					PopEdge(G,tn1.p2);
			}
		}
		else if (!tn1.p1 && !tn2.p1)//两个点均不在图中
		{
			p1 = NewNODE(n1,b);
			p2 = NewNODE(n2,b);
			Contact(p1, p2);
			PushEdge(G, p1);
		}
		else if (tn1.p1)
		{
			p1 = NewNODE(n2, b);
			Contact(tn1.p1, p1);
		}
		else
		{
			p2 = NewNODE(n1, b);
			Contact(tn2.p1, p2);
		}
	}
	
	void Input()//输入图
	{
		int n1, n2;
		while (true)
		{
			cin >> n1;
			if (n1 < 1) break;
			cin >> n2;
			Create(n1, n2);
		}
	}

	void output()
	{
		cout << endl << "先序遍历的结果::";
		output1(G->data,G->data->flage);
		cout << endl << "后序遍历的结果::";
		output2(G->data,G->data->flage);
		cout << endl << "广度优先遍历的结果::";
		output3(G->data,G->data->flage);
	}

	void output1(NODE *p,bool b)//先序遍历
	{
		EDGE *pe;
		if (p->flage != b) return;
		p->flage = !b;
		pe = p->next;
		cout << p->n << " ";
		while (pe)
		{
			output1(pe->data,b);
			pe = pe->next;
		}
	}

	void output2(NODE *p,bool b)//后序遍历
	{
		EDGE *pe;
		if (p->flage != b) return;
		p->flage = !b;
		pe = p->next;
		while (pe)
		{
			output2(pe->data,b);
			pe = pe->next;
		}
		cout << p->n << " ";
	}
	
	void output3(NODE *p,bool b)//广度优先
	{
		EDGE *E1,*E2,*t;
		E1 = E2 = NULL;
		PushEdge(E1, p);
		while (true)
		{
			if (E1->data->flage == b)
			{
				cout << E1->data->n << " ";
				t = E1->data->next;
				while (t)
				{
					if (t->data->flage == b)
						PushEdge(E2, t->data);
					t = t->next;
				}
			}
			E1->data->flage = !b;
			E1 = E1->next;
			if (!E1)
			{
				if (!E2)
					break;
				E1 = E2;
				E2 = NULL;
			}
			
		}
	}
};

int main()
{
	Graph G;
	G.Input();
	G.output();
    return 0;
}
