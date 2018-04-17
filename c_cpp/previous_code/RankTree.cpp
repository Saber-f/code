#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class ranktree/*{{{*/
{
	private:/*{{{*/
		typedef struct node
		{
			int data;
			struct node *next[2];
		}NODE;

		NODE *T,*pT;/*}}}*/

	public:
		ranktree()//define a constructors{{{
		{
			pT = T = NULL;
		}/*}}}*/

		~ranktree()//define a destructor{{{
		{
			initialize_pT();
			destroy();	
		}/*}}}*/
		
		void rankpush(int n)//add the n order in the tree {{{
		{
			NODE *p=new NODE[1],* pt;
			p->data = n;
			p->next[0] = p->next[1] = NULL; 
			if(!T)
			{
				T = p;
				return;
			}
			
			pt = T;
			while(true)
			{
				if(n < pt->data)
				{
					if(pt->next[0] == NULL)
					{
						pt->next[0] = p;
						break;
					}
					else 
						pt = pt->next[0];
				}
				else 
				{
					if(pt->next[1] == NULL)
					{
						pt->next[1] = p;
						break;
					}
					else 
						pt = pt->next[1];
				}
			}
		}/*}}}*/

		void input()//define the input fuction{{{
		{
			char c = 0;
			int n;
			while(c != 10)
			{
				cin >> n;
				rankpush(n);
				c = getchar();
			}
		}			/*}}}*/

		void initialize_pT()/*{{{*/
		{
			pT = T;
		}/*}}}*/

		void mid()//in the seaue traversal and print the node {{{
		{	
			NODE *p;	
			if(!pT)
				return;
			p = pT;
			pT = p->next[0];
			mid();
			cout << p->data << " ";
			pT = p->next[1];
			mid();
		}	/*}}}*/

		void destroy()//destroy tree {{{
		{
			NODE *p;
			if(!T)
				return;
			p = T;
			//postorder traversal
			T = p->next[0];
			destroy();
			T = p->next[1];
			destroy();
			delete(p);

			//inorder traversal
			/*	
			T = p->next[0];
			destroy();
			delete(p);
			T = p->next[1];
			destroy();
			*/ 

			//preorder traversal*
			/*	
			delete(p);
			T = p->next[0];
			destroy();
			T = p->next[1];
			destroy();
			*/ 
		}/*}}}*/

};/*}}}*/

int main(void)/*{{{*/
{
	ranktree rt;
	rt.input();
	rt.initialize_pT();
	rt.mid();
	cout << endl;
	return 0;
}/*}}}*/

