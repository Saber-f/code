#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class BalanceTree
{
	private:/*{{{*/
		typedef struct node
		{
			int data;
			struct node *left,*right;
		}NODE;

		NODE *BT;/*}}}*/

	public:
		BalanceTree()/*{{{*/
		{
			BT = NULL;
		}/*}}}*/

		~BalanceTree() /*{{{*/
		{
			destory(BT);//销毁二叉树
		}/*}}}*/

		void destory(NODE *p) /*{{{*/
		{
			if(!p)
				return;
			destory(p->left);
			destory(p->right);
			delete(p);
		}/*}}}*/

		void sowp(NODE *p1,NODE *p2)//交换p1,p2的成员数据{{{
		{
			int data;
			data = p1->data;p1->data = p2->data;p2->data = data;
		}/*}}}*/

		void LL(NODE *&p)/*{{{*/
		{
			NODE *cp;
			sowp(p,p->left);
			cp = p->left;
			p->left = p->left->left;
			cp->left = cp->right;
			cp->right = p->right;
			p->right = cp;
		}/*}}}*/

		void RR(NODE *&p)/*{{{*/
		{
			NODE *cp = p;
			sowp(p,p->right);
			cp = p->right;
			p->right = p->right->right;
			cp->right = cp->left;
			cp->left = p->left;
			p->left = cp;
		}/*}}}*/

		void LR(NODE *&p)/*{{{*/
		{
			sowp(p,p->left->right);
			if(p->left->right->right)
				p->left->right->left = p->left->right->right;
			p->left->right->right = p->right;
			p->right = p->left->right;
			p->left->right = NULL;
		}/*}}}*/

		void RL(NODE *&p)/*{{{*/
		{
			sowp(p,p->right->left);
			if(p->right->left->left)
				p->right->left->right = p->right->left->left;
			p->right->left->left = p->left;
			p->left = p->right->left;
			p->right->left = NULL;
		}/*}}}*/

		void push(NODE *&p,int data)//入栈{{{
		{
			if(!p)
			{
				p = new NODE[1];
				p->data = data;
				p->left = p->right = NULL;
				return;
			}
			else 
			{
				if(data <= p->data)
					push(p->left,data);
				else 
					push(p->right,data);
			}
		}/*}}}*/

		void adjust(NODE *&p)//调整树p为平衡树{{{
		{
			int n1,n2,n3;
			if(!p)
				return;
			adjust(p->left);
			adjust(p->right);	

			n1 = get_info(p);
			if(n1 == 2)
			{
				n2 = get_info(p->left);
				if(n2 == 1)
					LL(p);
				else if(n2 == -1)
					LR(p);
			}
			else if(n1 == -2)
			{
				n3 = get_info(p->right);
				if(n3 == -1)
					RR(p);
				else if(n3 == 1)
					RL(p);
			}
		}/*}}}*/

		void input()/*{{{*/
		{
			int data;
			char c = 0;
			cout << "plwase input::";
			while(c != 10)
			{
				cin >> data;
				push(BT,data);
				adjust(BT);
				c = getchar();
			}
		}/*}}}*/

		int get_info(NODE *p)//左子树的深度减右子树的深度{{{
		{
			if(!p)
				return 0;
			return deep(p->left) - deep(p->right);
		}/*}}}*/

		int deep(NODE *p)//获取树的深度/*{{{*/
		{
			int d1,d2;
			if(!p)
				return 0;
			d1 = deep(p->left) + 1;
			d2 = deep(p->right) + 1;
			return d1 > d2 ? d1 : d2;
		}/*}}}*/

		void output()/*{{{*/
		{
			print(BT);
			cout << endl << "deepin::" << deep(BT) << endl ;
		}/*}}}*/

		void print(NODE *p)/*{{{*/
		{
			if(!p)
				return;
			print(p->left);
			cout << p->data << " " ;
			print(p->right);
		}/*}}}*/

};

int main(void)/*{{{*/
{
	BalanceTree BT;
	BT.input();
	BT.output();
	return 0;
}/*}}}*/
