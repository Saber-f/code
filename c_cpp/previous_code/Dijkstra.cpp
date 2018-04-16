#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class dijstra
{
	typedef struct node_/*{{{*/
	{
		int data;
		struct node_ *next;
	}NODE_;/*}}}*/

	typedef struct node/*{{{*/
	{
		NODE_ *node;
		double length;
		struct node *next;
	}NODE;

	NODE *D,*A,*B;/*}}}*/
	public:
		dijstra()//define constructor{{{
		{
			D = A = B = NULL;
		}	/*}}}*/

		~dijstra()//define destructor{{{
		{
			NODE *p;
			while(D)
			{
				p = D->next;
				mydelete(D);
				D = p;
			}	
			while(A)
			{
				p = A->next;
				mydelete(A);
				A = p;
			}	
			while(B)
			{
				p = B->next;
				mydelete(B);
				B = B->next;
			}	
		
		}/*}}}*/

		void mydelete(NODE *p)//删除节点p{{{
		{
			NODE_ *p_;
			while(p->node)
			{
				p_ = p->node->next;
				delete(p->node);
				p->node = p_;
			}
			delete(p);
		}/*}}}*/
		
		void push_(NODE_ *&P,int data)//入栈{{{
		{
			NODE_ *p;
			p = new NODE_[1];
			p->data = data;
			p->next = P;
			P = p;
		}/*}}}*/

		void insert_tail(NODE_ *&p,int data)//向p中尾插data{{{
		{
			NODE_ *cp;
			if(!p)
			{
				p = new NODE_[1];
				p->data = data;
				p->next = NULL;
			}
			else 
			{
				cp = p;
				while(cp->next)
					cp = cp->next;
				cp->next = new NODE_[1];
			       	cp->next->data = data;	
			 	cp->next->next = NULL;	
			}
		}/*}}}*/

		void com(NODE_ *p1,NODE_ *p2)//合并p1,p2 {{{
		{
			p2 = p2->next;
			while(p2)
			{
				insert_tail(p1,p2->data);
				p2 = p2->next;
			}
		}/*}}}*/

		void push(NODE *&P,int n1,int n2,double length)//向P入栈 {{{
		{
			NODE *p = new NODE[1];
			p->node = NULL;
			push_(p->node,n1);
			push_(p->node,n2);
			p->length = length;
			p->next = P;
			P = p;
		}/*}}}*/

		void input_an()//输入所有起始点小于1结束输入{{{
		{
			int nd1,nd2;
			double d;
			cout << "please input data(< 1 over)" << endl;
			while(true)
			{
				cin >> nd1;
				if(nd1 < 1)
					break;
				cin >> nd2 >> d;
				push(D,nd1,nd2,d);
			}
		}/*}}}*/
	
		void delete_node(NODE *&p,int n)//删除p中终点为n的节点{{{
		{
			NODE *cp = p,*t;
			if(!p)
				return;
			while(cp->next)
			{
				if(cp->next->node->data == n)
				{
					t = cp->next->next;
					mydelete(cp->next);
					cp->next = t;
				}
				else
					cp = cp->next;
			}

			if(p->node->data == n)
			{
				t = p->next;
				mydelete(p);
				p = t;
			}
		}/*}}}*/

		int get_b(NODE_ *p)/*{{{*/
		{
			if(!p)
			{
				cout << "error ! -1" << endl;
				exit(-1);
			}
			while(p->next) 
				p = p->next;
			return p->data;
		}/*}}}*/

		void insert(NODE *p,NODE *&q,NODE *rq)/*{{{*/
		{
			NODE_ *p_;
			NODE *t2;
			if(!q)
			{

				q = p;
				if(rq)
				{
					q->length += rq->length;
					com(q->node,rq->node);
				}
				q->next = NULL;
			}
			else 
			{
				if(rq)	
					p->length += rq->length;
				t2 = q;
				while(true)
				{
					if(t2->node->data == p->node->data)
					{
						if(p->length < t2->length)
						{
							t2->length = p->length;
							if(rq)	
								com(p->node,rq->node);
							p_ = t2->node;t2->node = p->node;p->node = p_;
						}
						mydelete(p);
						break;
					}
					if(!t2->next)
					{
						if(rq)
							com(p->node,rq->node);
						t2->next = p;
						t2->next->next = NULL;
						break;
					}
					t2 = t2->next;
				}
			}
		}/*}}}*/

		void remove(NODE *&p,int n,NODE *&q,NODE *rq)//删除p中使点为n的节点，并移入q中{{{
		{
			int m;
			NODE *cp = p,*t;
			if(!p) return;
			while(cp->next)
			{
				m = get_b(cp->next->node);
				if(m == n)
				{
					t = cp->next->next;
					insert(cp->next,q,rq);
					cp->next = t;
				}
				else
					cp = cp->next;
			}	
			m = get_b(p->node);		
			if(m == n)
			{
				t = p->next;
				insert(p,q,rq);
				p = t;
			}
		}/*}}}*/

		NODE *remove_min(NODE *&A,NODE *&B)//将A中最短的移动到B{{{
		{
			NODE *p = A,*cp = A;
			double length = p->length;
			cp = cp->next;
			while(cp)
			{
				if(cp->length < length)
				{
					p = cp;
					length = p->length;
				}
				cp = cp->next;
			}

			if(p == A)
			{
				A = A->next;
				p->next = B;
				B = p;
				return p;
			}

			cp = A;
			while(p != cp->next)
				cp = cp->next;
			cp->next = cp->next->next;
			p->next = B;
			B = p;;
			return p;
		}/*}}}*/

		void input_bn()//输入开始的点并开始计算{{{
		{
			NODE *p = NULL;
			int n;
			cout << "please input begain node::" ;
			cin >> n;
			while(true)
			{
				delete_node(D,n);
				remove(D,n,A,p);
				if(!A) break;
				p = remove_min(A,B);
				n = p->node->data;
				
			}

		}/*}}}*/

		void outputD()/*{{{*/
		{
			cout << "The ans is::" << endl;
			output(D);
		}/*}}}*/

		void outputB()/*{{{*/
		{
			cout << "The ans is::" << endl;
			output(B);
		}/*}}}*/

		void output_(NODE_ *p)/*{{{*/
		{
			if(!p)
				return;
			output_(p->next);
			cout << p->data << "->" ;
		}/*}}}*/

		void output(NODE *p)//输出{{{
		{
			if(!p)
				return;
			output(p->next);
			output_(p->node);
			cout << "length::" << p->length << endl;
		}/*}}}*/
};
int main(void)/*{{{*/
{
	dijstra DJ;
	DJ.input_an();
	DJ.input_bn();
	DJ.outputB();
	return 0;
}/*}}}*/
