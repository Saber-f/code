#include <iostream>

using namespace std;

typedef struct tree_node {
	int data;
	struct tree_node *left, *right;
}T_NODE;

typedef struct stack_node {
	T_NODE *data;
	bool flage;
	struct stack_node *next;
}S_NODE;

class tree {
public:
	//将data插入顺序树
	void push(T_NODE *&T, int data)
	{
		T_NODE *p;
		if (!T) {
			T = new T_NODE;
			T->data = data;
			T->left = T->right = NULL;
			return;
		}
		p = T;
		while (true) {
			if (data <= p->data) {
				if (p->left)
					p = p->left;
				else {
					p->left = new T_NODE;
					p->left->data = data;
					p->left->left = p->left->right = NULL;
					return;
				}
			}
			else {
				if (p->right)
					p = p->right;
				else {
					p->right = new T_NODE;
					p->right->data = data;
					p->right->left = p->right->right = NULL;
					return;
				}
			}
		}
	}

	//输入一串数字到T中
	T_NODE *input()
	{
		int  data;
		T_NODE *T = NULL;
		do {
			scanf_s("%d", &data);
			push(T, data);
		} while (getchar() != '\n');
		return T;
	}

	//递归先序遍历
	void read_1(T_NODE *T)
	{
		if (!T) return;
		cout << T->data << " ";
		read_1(T->left);
		read_1(T->right);
	}

	//非递归先序遍历
	void read1(T_NODE *T)
	{
		S_NODE *S,*tS,*ttS;
		S = new S_NODE;
		S->data = T;
		S->next = NULL;
		cout << endl << "  递归先序遍历结果::";
		read_1(T);
		cout << endl << "非递归先序遍历结果::";
		do {
			if (S->flage) {
				S->flage = false;
				ttS = S;
				if (ttS->data->right) {
					tS = new S_NODE;
					tS->data = ttS->data->right;
					tS->next = S->next;
					tS->flage = true;
					S->next = tS;
				}
				if (ttS->data->left) {
					tS = new S_NODE;
					tS->data = ttS->data->left;
					tS->next = S->next;
					tS->flage = true;
					S->next = tS;
				}
			}
			else {
				cout << S->data->data << " ";
				tS = S;
				S = S->next;
				delete(tS);
			}
		} while (S);
		cout << endl;
	}

	//递归中序遍历结果
	void read_2(T_NODE *T)
	{
		if (!T) return;
		read_2(T->left);
		cout << T->data << " ";
		read_2(T->right);
	}

	//非递归中序遍历
	void read2(T_NODE *T)
	{
		S_NODE *S, *tS,*ttS;
		S = new S_NODE;
		S->data = T;
		S->flage = true;
		S->next = NULL;
		cout << endl <<  "  递归中序遍历结果::";
		read_2(T);
		cout << endl <<  "非递归中序遍历结果::";
		do {
			if (S->flage) {
				S->flage = false;
				ttS = S;
				if (ttS->data->right) {
					tS = new S_NODE;
					tS->data = ttS->data->right;
					tS->next = S->next;
					tS->flage = true;
					S->next = tS;
				}
				if (ttS->data->left) {
					tS = new S_NODE;
					tS->data = ttS->data->left;
					tS->next = S;
					tS->flage = true;
					S = tS;
				}
			}
			else {
				cout << S->data->data << " ";
				tS = S;
				S = S->next;
				delete(tS);
			}
		} while (S);
		cout << endl;
	}

	//递归后序遍历结果
	void read_3(T_NODE *T)
	{
		if (!T) return;
		read_3(T->left);
		read_3(T->right);
		cout << T->data << " ";
	}

	//非递归后序遍历
	void read3(T_NODE *T)
	{
		S_NODE *S,*tS,*ttS;
		S = new S_NODE;
		S->data = T;
		S->flage = true;
		S->next = NULL;
		cout << endl <<  "  递归后序遍历结果::" ;
		read_3(T);
		cout << endl <<  "非递归后序遍历结果::";
		do {
			if (S->flage) {
				S->flage = false;
				ttS = S;
				if (ttS->data->right) {
					tS = new S_NODE;
					tS->data = ttS->data->right;
					tS->next = S;
					tS->flage = true;
					S = tS;
				}
				if (ttS->data->left) {
					tS = new S_NODE;
					tS->data = ttS->data->left;
					tS->next = S;
					tS->flage = true;
					S = tS;
				}
			}
			else {
				cout << S->data->data << " ";
				tS = S;
				S = S->next;
				delete(tS);
			}
		} while (S);
		cout << endl;
	}

	//销毁树
	void destory(T_NODE *T)
	{
		if (!T) return;
		destory(T->left);
		destory(T->right);
		delete(T);
	}

};

int main(void)
{
	T_NODE *T;
	tree TR;
	T = TR.input();
	TR.read1(T);
	TR.read2(T);
	TR.read3(T);
	TR.destory(T);
	return 0;
}
