#include<iostream>

using namespace std;

class tree
{
	typedef struct node
	{
		int data;
		struct node *left, *right;
	}NODE;

	NODE *H;

public:
	tree()//构造
	{
		H = NULL;
	}

	~tree()//析构
	{
		Destory(H);
	}

	void Destory(NODE *p)//销毁
	{
		if (!p) return;
		Destory(p->left);
		Destory(p->right);
		delete(p);
	}

	int GetDeep(NODE *p)//求数的深度
	{
		int n1, n2;
		if (!p)
			return 0;
		n1 = GetDeep(p->left) + 1;
		n2 = GetDeep(p->right) + 1;
		return n1 > n2 ? n1 : n2;
	}

	int Get1or0(NODE *p)//左子树深度减右子树深度
	{
		if (!p)
			return 0;
		return GetDeep(p->left) - GetDeep(p->right);
	}

	bool IsComplete(NODE *p)//判断是否为完全树
	{
		if (Get1or0(p))
			return false;
		else if (!p)
			return true;
		else
			return IsComplete(p->left) && IsComplete(p->right); 
	}

	NODE *GetWhereInsert(NODE *p)//得到顺序的插入的节点指针
	{
		NODE *t;
		if (IsComplete(p))
		{
			t = p;
			while (t->left)
				t = t->left;
			t->left = new NODE;
			return t->left;
		}
		else if (IsComplete(p->left))
		{
			if (!p->right)
			{
				p->right = new NODE;
				return p->right;
			}
			else
				return GetWhereInsert(p->right);
		}
		else
			return GetWhereInsert(p->left);
	}

	void Push(NODE *&p,int data)//顺序生成树
	{
		NODE *w;
		if (!p)
		{
			p = new NODE;
			p->data = data;
			p->left = NULL;
			p->right = NULL;
			return;
		}
		w = GetWhereInsert(p);
		w->left = w->right = NULL;
		w->data = data;
	}

	void Input(void)//输入数据
	{
		int data;
		char c = 0;
		while (c != 10)
		{
			cin >> data;
			c = getchar();
			Push(H, data);
		}
	}

	void swop(NODE *p1, NODE *p2)//交换两个结点的值
	{
		int t;
		t = p1->data;
		p1->data = p2->data;
		p2->data = t;
	}
	
	void base_adjust(NODE *p)//调整使得父节点比儿子节点大
	{
		if (p->left)
		{
			if (p->right)
			{
				if (p->left->data > p->right->data)
				{
					if (p->left->data > p->data)
					{
						swop(p, p->left);
						base_adjust(p->left);
					}
				}
				else
				{
					if (p->right->data > p->data)
					{
						swop(p, p->right);
						base_adjust(p->right);
					}
				}
			}
			else
			{
				if (p->left->data > p->data)
				{
					swop(p, p->left);
					base_adjust(p->left);
				}
			}
		}
	}

	void adjust(NODE *p)//调整为堆
	{
		if (!p)	return;
		adjust(p->left);
		adjust(p->right);
		base_adjust(p);
	}

	bool DeleteTail(NODE *p)//末端叶子的值赋给根结点，并删除末端叶子
	{
		NODE *t;
		if (IsComplete(p))
		{
			if (!p->right)
				return true;
			t = p;
			while (t->right->right)
				t = t->right;
			H->data = t->right->data;
			delete(t->right);
			t->right = NULL;
			return false;
		}
		else if (IsComplete(p->left))
		{
			if (!p->right)
			{
				H->data = p->left->data;
				delete(p->left);
				p->left = NULL;
				return false;
			}
			else if (IsComplete(p->right))
				return DeleteTail(p->left);
			else
				return DeleteTail(p->right);
		}
		else
			return DeleteTail(p->left);
	}

	void sort()//堆排序并输出结果
	{
		adjust(H);
		while (true)
		{
			cout << H->data << " ";
			if (DeleteTail(H))
				break;
			base_adjust(H);
		}
		cout << endl;
	}
};

int main(void)
{
	tree T;
	T.Input();
	T.sort();
	return 0;
}
