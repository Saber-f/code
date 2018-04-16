#include<iostream>

using namespace std;

class tree
{
public:
	typedef struct node
	{
		int data;
		struct node *left, *right;
		bool fleft, fright;
	}NODE;

	NODE *pre;
	NODE *T;

	tree()
	{
		T = NULL;
		pre = new NODE;
		pre->left = pre->right = NULL;
		pre->fleft = pre->fright = NULL;
		pre->data = 0;
	}

	~tree()
	{
	
		free(pre);
	}

	void push(NODE *&p,int data)
	{
		if (!p)
		{
			p = new NODE;
			p->data = data;
			p->left = NULL;
			p->right = NULL;
			p->fleft = false;
			p->fright = false;
			return;
		}
		if (data <= p->data)
			push(p->left,data);
		else
			push(p->right, data);
	}

	void input()
	{
		int data;
		char c = 0;
		while (c != 10)
		{
			cin >> data;
			c = getchar();
			push(T, data);
		}
	}

	void clue()
	{
		NODE *p = pre;
		clue(T);
		pre->right = p;
		pre->fright = true;
		p->left = pre;
		p->fleft = true;
		pre = p;
	}

	void clue(NODE *p)
	{
		if (!p)
			return;
		clue(p->left);
		if (!p->left)
		{
			p->left = pre;
			p->fleft = true;
		}
		if (!pre->right)
		{
			pre->right = p;
			pre->fright = true;
		}
		pre = p;
		clue(p->right);
	}

	void output()
	{
		NODE *p;
		
		//顺序遍历
		p = pre->right;
		while (true)
		{
			cout << p->data << " ";
			while (p->fright)
			{
				p = p->right;
				if (p == pre)
					break;
				cout << p->data << " ";
			}
			if (p == pre)
				break;
			p = p->right;
			while (!p->fleft)
				p = p->left;
		}
		cout << endl;
		

		//逆序遍历
		p = pre->left;
		while (true)
		{
			cout << p->data << " ";
			while (p->fleft)
			{
				p = p->left;
				if (p == pre)
					break;
				cout << p->data << " ";
			}
			if (p == pre)
				break;
			p = p->left;
			while (!p->fright)
				p = p->right;
		}
		cout << endl;
	}
};

int main(void)
{
	tree T;
	T.input();
	T.clue();
	T.output();
	return 0;
}
