// Floyd.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class Floyd
{
private:/*{{{*/
	typedef struct node_y
	{
		int y;
		double data;
		struct node_y *left, *right;
	}NODE_Y;

	typedef struct node_x
	{
		int x;
		NODE_Y *data;
		struct node_x *left, *right;
	}NODE_X;

	int  max;
	NODE_X *A;/*}}}*/

public:
	//定义以及销毁{{{
	Floyd()//定义构造函数{{{
	{
		max = 0;
		A = NULL;
	}/*}}}*/

	~Floyd()//定义析构函数{{{
	{
		destory_x(A);
	}/*}}}*/

	void destory_y(NODE_Y *p)//销毁y型节点{{{
	{
		if (!p) return;
		destory_y(p->left);
		destory_y(p->right);
		delete(p);
	}/*}}}*/

	void destory_x(NODE_X *p)//销毁x型节点{{{
	{
		if (!p) return;
		destory_x(p->left);
		destory_x(p->right);
		destory_y(p->data);
		delete(p);
	}/*}}}*//*}}}*/

	//交换{{{
	void sowp_y(NODE_Y *p1, NODE_Y *p2)//交换p1,p2的成员数据{{{
	{
		int y;
		double data;
		y = p1->y; p1->y = p2->y; p2->y = y;
		data = p1->data; p1->data = p2->data; p2->data = data;
	}/*}}}*/

	void sowp_x(NODE_X *p1, NODE_X *p2)//交换p1,p2的成员数据{{{
	{
		int x;
		NODE_Y *data;
		x = p1->x; p1->x = p2->x; p2->x = x;
		data = p1->data; p1->data = p2->data; p2->data = data;
	}/*}}}*//*}}}*/

	//旋转{{{
	void LL_X(NODE_X *&p)/*{{{*/
	{
		NODE_X *cp;
		sowp_x(p, p->left);
		cp = p->left;
		p->left = p->left->left;
		cp->left = cp->right;
		cp->right = p->right;
		p->right = cp;
	}/*}}}*/

	void LL_Y(NODE_Y *&p)/*{{{*/
	{
		NODE_Y *cp;
		sowp_y(p, p->left);
		cp = p->left;
		p->left = p->left->left;
		cp->left = cp->right;
		cp->right = p->right;
		p->right = cp;
	}/*}}}*/

	void RR_X(NODE_X *&p)/*{{{*/
	{
		NODE_X *cp = p;
		sowp_x(p, p->right);
		cp = p->right;
		p->right = p->right->right;
		cp->right = cp->left;
		cp->left = p->left;
		p->left = cp;
	}/*}}}*/

	void RR_Y(NODE_Y *&p)/*{{{*/
	{
		NODE_Y *cp = p;
		sowp_y(p, p->right);
		cp = p->right;
		p->right = p->right->right;
		cp->right = cp->left;
		cp->left = p->left;
		p->left = cp;
	}/*}}}*/

	void LR_X(NODE_X *&p)/*{{{*/
	{
		if (p->left->right->left)
			sowp_x(p->left->right, p->left->right->left);
		else
			p->left->right->left = p->left->right->right;
		sowp_x(p, p->left->right);
		p->left->right->right = p->right;
		p->right = p->left->right;
		p->left->right = NULL;
	}/*}}}*/

	void LR_Y(NODE_Y *&p)/*{{{*/
	{
		if (p->left->right->left)
			sowp_y(p->left->right, p->left->right->left);
		else
			p->left->right->left = p->left->right->right;
		sowp_y(p, p->left->right);
		p->left->right->right = p->right;
		p->right = p->left->right;
		p->left->right = NULL;
	}/*}}}*/

	void RL_X(NODE_X *&p)/*{{{*/
	{
		if (p->right->left->right)
			sowp_x(p->right->left, p->right->left->right);
		else
			p->right->left->right = p->right->left->left;
		sowp_x(p, p->right->left);
		p->right->left->left = p->left;
		p->left = p->right->left;
		p->right->left = NULL;
	}/*}}}*/

	void RL_Y(NODE_Y *&p)/*{{{*/
	{
		if (p->right->left->right)
			sowp_y(p->right->left, p->right->left->right);
		else
			p->right->left->right = p->right->left->left;
		sowp_y(p, p->right->left);
		p->right->left->left = p->left;
		p->left = p->right->left;
		p->right->left = NULL;
	}/*}}}*//*}}}*/

	//插入数据{{{
	void push_y(NODE_Y *&p, int y, double data)//定义插入y型{{{
	{
		if (!p)
		{
			p = new NODE_Y[1];
			p->y = y;
			p->data = data;
			p->left = p->right = NULL;
		}
		else
		{
			if (y == p->y)
				p->data = data;
			else if (y < p->y)
				push_y(p->left, y, data);
			else
				push_y(p->right, y, data);
		}
	}/*}}}*/

	void push(NODE_X *&p, int x, int y, double data)//定义入栈函数{{{
	{
		int t = x > y ? x : y;
		if (max < t) max = t;
		if (!p)
		{
			p = new NODE_X[1];
			p->data = NULL;
			p->x = x;
			push_y(p->data, y, data);
			adjust_y(p->data);
			p->left = p->right = NULL;
		}
		else
		{
			if (x == p->x)
			{
				push_y(p->data, y, data);
				adjust_y(p->data);
			}
			else if (x < p->x)
				push(p->left, x, y, data);
			else
				push(p->right, x, y, data);
		}
	}/*}}}*//*}}}*/

	//调整{{{
	void adjust_x(NODE_X *&p)//调整树p为平衡树{{{
	{
		double d;
		int n1, n2, n3;
		if (!p)
			return;
		adjust_x(p->left);
		adjust_x(p->right);

		n1 = get_info_x(p);
		if (n1 == 2)
		{
			n2 = get_info_x(p->left);
			if (n2 == 1)
				LL_X(p);
			else if (n2 == -1)
				LR_X(p);
		}
		else if (n1 == -2)
		{
			n3 = get_info_x(p->right);
			if (n3 == -1)
				RR_X(p);
			else if (n3 == 1)
				RL_X(p);
		}
		d = read(A, 4, 3);
		d = d;
	}/*}}}*/

	void adjust_y(NODE_Y *&p)//调整树p为平衡树{{{
	{
		int n1, n2, n3;
		if (!p)
			return;
		adjust_y(p->left);
		adjust_y(p->right);

		n1 = get_info_y(p);
		if (n1 == 2)
		{
			n2 = get_info_y(p->left);
			if (n2 == 1)
				LL_Y(p);
			else if (n2 == -1)
				LR_Y(p);
		}
		else if (n1 == -2)
		{
			n3 = get_info_y(p->right);
			if (n3 == -1)
				RR_Y(p);
			else if (n3 == 1)
				RL_Y(p);
		}
	}/*}}}*//*}}}*/

	void input()/*{{{*/
	{
		int x, y;
		double data,data1;
		cout << "plwase input::" << endl;
		while (true)
		{
			cin >> x;
			if (x < 1)
				break;
			cin >> y >> data;
			push(A, x, y, data);
			adjust_x(A);
		}
		cout << "The adjacent matrix::" << endl;
		dis(A);
		for(int i = 1; i <= max;i++)
			for(int j = 1;j <= max;j++)
				for (int k = 1; k <= max; k++)
				{
					if (j == k) continue;
					data = read(A, i, k);
					if (data == 0) continue;
					data1 = read(A, j, i);
					if (data1 == 0) continue;
					data += data1;
					data1 = read(A, j, k);
					if (data1 == 0 || data1 > data)
						push(A, j, k, data);
				}
		cout << "The distance matrix::" << endl;
		dis(A);
	}/*}}}*/

	//平衡判断{{{
	int deep_x(NODE_X *p)//获取树的深度/*{{{*/
	{
		int d1, d2;
		if (!p)
			return 0;
		d1 = deep_x(p->left) + 1;
		d2 = deep_x(p->right) + 1;
		return d1 > d2 ? d1 : d2;
	}/*}}}*/

	int deep_y(NODE_Y *p)//获取树的深度/*{{{*/
	{
		int d1, d2;
		if (!p)
			return 0;
		d1 = deep_y(p->left) + 1;
		d2 = deep_y(p->right) + 1;
		return d1 > d2 ? d1 : d2;
	}/*}}}*/

	int get_info_x(NODE_X *p)//左子树的深度减右子树的深度{{{
	{
		if (!p)
			return 0;
		return deep_x(p->left) - deep_x(p->right);
	}/*}}}*/

	int get_info_y(NODE_Y *p)//左子树的深度减右子树的深度{{{
	{
		if (!p)
			return 0;
		return deep_y(p->left) - deep_y(p->right);
	}/*}}}*//*}}}*/

	//读取展示{{{
	double read_y(NODE_Y *p, int y)// {{{
	{
		if (!p)
			return 0;
		if (p->y == y)
			return p->data;
		else if (y < p->y)
			return read_y(p->left, y);
		else
			return read_y(p->right, y);
	}/*}}}*/

	double read(NODE_X *p, int x, int y)//读取第x行第y列的值{{{
	{
		if (!p)
			return 0;
		if (p->x == x)
			return read_y(p->data, y);
		else if (x < p->x)
			return read(p->left, x, y);
		else
			return read(p->right, x, y);
	}/*}}}*/

	void dis(NODE_X *p)/*{{{*/
	{
		double data;
		cout << "   ";
		for (int i = 1; i <= max; i++) cout << " " << i << " ";
		cout << endl;
		for (int i = 1; i <= max; i++)
		{
			cout << " " << i << " ";
			for (int j = 1; j <= max; j++)
			{
				data = read(p, i, j);
				if (data == 0)
					cout << " x ";
				else
					printf("%2g ", data);
			}
			cout << endl;
		}
	}/*}}}*//*}}}*/
};

int main(void)/*{{{*/
{
	Floyd F;
	F.input();
	return 0;
}/*}}}*/
