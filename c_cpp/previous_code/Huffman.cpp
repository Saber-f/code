// Huffman.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class HuffmanTree/*{{{*/
{
private:/*{{{*/
	typedef struct node
	{
		int data;
		struct node *next[2];
	}NODE;

	typedef struct point
	{
		NODE *data;
		struct point *next;
	}POINT;

	bool *Ans;

	NODE *H;//树根}}}

public:
	HuffmanTree()//difine constructor function{{{
	{
		H = NULL;
	}/*}}}*/

	~HuffmanTree()//define destructor function{{{
	{
		destory(H);
	}/*}}}*/

	void destory(NODE *p)//define destory function{{{
	{
		if (!p)
			return;
		destory(p->next[0]);
		destory(p->next[1]);
		delete(p);
	}/*}}}*/

	void push(POINT *&p, NODE *data)//push and rank{{{
	{
		POINT *t, *cp;
		if (!p)
		{
			p = new POINT[1];
			p->data = data;
			p->next = NULL;
			return;
		}

		t = new POINT[1];
		t->data = data;
		if (data->data < p->data->data)
		{
			t->next = p;
			p = t;
			return;
		}

		cp = p;
		while (cp->next)
		{
			if (data->data < cp->next->data->data)
				break;
			cp = cp->next;
		}
		t->next = cp->next;
		cp->next = t;
	}/*}}}*/

	void create()/*{{{*/
	{
		char c = 0;
		POINT *D = NULL, *p;
		NODE *data;
		cout << "please input data::";
		while (c != 10)
		{

			data = new NODE[1];
			cin >> data->data;
			data->next[0] = data->next[1] = NULL;
			push(D, data);
			c = getchar();
		}
		while (D->next)
		{
			data = new NODE[1];
			data->data = D->data->data + D->next->data->data;
			data->next[0] = D->data;
			data->next[1] = D->next->data;
			p = D;
			D = D->next->next;
			delete(p->next);
			delete(p);
			push(D, data);
		}
		H = D->data;
		delete(D);
	}/*}}}*/

	int getdeep(NODE *p)/*{{{*/
	{
		int d0 = 0, d1 = 0;
		if (!p)
			return 0;
		if (p->next[0])
			d0 = getdeep(p->next[0]);
		if (p->next[1])
			d1 = getdeep(p->next[1]);

		return d0 > d1 ? ++d0 : ++d1;
	}/*}}}*/

	void output()/*{{{*/
	{
		int size = getdeep(H);
		Ans = new bool[size];
		cout << "deepin::" << size << endl;
		output1(0, H);

	}/*}}}*/

	void output1(int i, NODE *p)/*{{{*/
	{
		if (!p->next[0] && !p->next[1])
		{
			printf("  %10d::", p->data);
			for (int j = 0; j < i; j++)
				cout << (int)Ans[j];
			cout << endl;
			return;
		}
		Ans[i] = 0;
		output1(i + 1, p->next[0]);
		Ans[i] = 1;
		output1(i + 1, p->next[1]);
	}/*}}}*/

};/*}}}*/

int main(void)/*{{{*/
{
	HuffmanTree HT;
	HT.create();
	HT.output();
	return 0;
}/*}}}*/

