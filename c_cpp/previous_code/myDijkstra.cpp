#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class dijstra
{
	typedef struct node/*{{{*/
	{
		int origin,destination;;
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
			while(A)
			{
				p = A->next;
				delete(A);
				A = p;
			}	
			while(B)
			{
				p = B->next;
				delete(B);
				B = B->next;
			}	
		
		}/*}}}*/

		void push(NODE *&D,int origin,int destination,double length)//向D入栈 {{{
		{
			NODE *p = new NODE[1];
			p->origin = origin;
			p->destination = destination;
			p->length = length;
			p->next = D;
			D = p;
		}/*}}}*/

		void input_an()//输入所有起始点小于1结束输入{{{
		{
			int origin,destination;
			double length;
			cout << "please input data(< 1 over)" << endl;
			while(true)
			{
				cin >> origin;
				if(origin < 1)
					break;
				cin >> destination >> length;
				push(D,origin,destination,length);
			}
		}/*}}}*/
	
		void delete_node(NODE *&D,int n)//删除D中终点为n的节点{{{
		{
			NODE *cD = D,*t;
			if(!D) return;
			while(cD->next)
			{
				if(cD->next->destination == n)
				{
					t = cD->next->next;
					delete(cD->next);
					cD->next = t;
				}
				else
					cD = cD->next;
			}

			if(D->destination == n)
			{
				t = D->next;
				delete(D);
				D = t;
			}
		}/*}}}*/

		void insert(NODE *p,NODE *&q,NODE *rq)/*{{{*/
		{
			NODE *t;
			if(!q)
			{
				q = p;
				if(rq)
					q->length += rq->length;
				q->next = NULL;
			}
			else 
			{
				if(rq)	
					p->length += rq->length;
				t = q;
				while(true)
				{
					if(t->destination == p->destination && t->length != p->length)
					{
						if(p->length < t->length)
						{
							t->length = p->length;
							t->origin = p->origin;
						}
						delete(p);
						break;
					}
					if(!t->next)
					{
						t->next = p;
						t->next->next = NULL;
						break;
					}
					t = t->next;
				}
			}
		}/*}}}*/

		void remove(NODE *&D,int origin,NODE *&A,NODE *rq)//将D中始点为origin的节点移入A中{{{
		{
			NODE *cD = D,*t;
			if(!D) return;
			while(cD->next)
			{
				if(cD->next->origin == origin)
				{
					t = cD->next->next;
					insert(cD->next,A,rq);
					cD->next = t;
				}
				else
					cD = cD->next;
			}	
			if(D->origin  == origin)
			{
				t = D->next;
				insert(D,A,rq);
				D = t;
			}
		}/*}}}*/

		NODE *remove_min(NODE *&A,NODE *&B)//将A中最短的移动到B{{{
		{
			NODE *p = A,*cp;
			int destination = 0;
			if(!A) return NULL;
			double minlength = A->length;
			p = p->next;
			while(p)
			{
				if(p->length < minlength)
					minlength = p->length;
				p = p->next;
			}
			
			p = A;
			while(p->next)
			{
				if(p->next->length == minlength) 
				{
					if(destination && destination != p->next->destination)
						return cp;
					cp = p->next;
					p->next = p->next->next;
				       	cp->next = B;
					B = cp;
					destination = B->destination;
				}	
				else
					p = p->next;
			}

			if(minlength == A->length)
			{
				if(destination && destination != A->destination)
					return cp;
				cp = A;
				A = A->next;
				cp->next = B;
				B = cp;
			}
			return cp;
		}/*}}}*/

		int get_n(NODE *p)/*{{{*/
		{
			int n = 0;
			while(p)
			{
				n++;
				p = p->next;
			}
			return n;
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
				n = p->destination;	
			}
		}/*}}}*/

		void outputB()/*{{{*/
		{
			cout << "The ans is::" << endl;
			output(B);
		}/*}}}*/

		void output(NODE *p)//输出{{{
		{
			if(!p)
				return;
			output(p->next);
			cout << p->origin << "->" << p->destination << "  length::" << p->length << endl;
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
