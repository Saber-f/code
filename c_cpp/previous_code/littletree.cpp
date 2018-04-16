#include<iostream>/*{{{*/

using namespace std;/*}}}*/

class MinTree/*{{{*/
{
	private:/*{{{*/
		typedef struct node 
		{
			int data;
			struct node *next;
		}NODE;

		typedef struct edge  
		{
			int n1;
			int n2;
			double d;
			struct edge *next; 
		}EDGE;
	
		int n;
		NODE *SN;
		EDGE *SE;/*}}}*/

	public:
		MinTree()//定义构造函数{{{
		{
			n = 0;
			SN = NULL;
			SE = NULL;
		}	/*}}}*/

		~MinTree()//定义析构函数{{{
		{
			NODE *p;
			EDGE *p2;
			while(SN)
			{
				p = SN->next;
				delete(SN);
				SN = p;
			}
			while(SE)
			{
				p2 = SE->next;
				delete(SE);
				SE = p2;
			}
			
		}/*}}}*/
			
		bool PushN(int in)//点入栈{{{
		{
			NODE *p;
			p = SN;
			while(p)
			{
				if(p->data == in)
					return false;
				p = p->next;
			}
			p = new NODE[1];
			p->data = in;
			p->next = SN;
			SN = p;
			n++;
			return true;
		}/*}}}*/

		void PopN()//点出栈{{{
		{
			NODE *p = SN;
			if(!SN)
				return;
			SN = SN->next;
			delete(p);
		}/*}}}*/

		void PushE(int n1,int n2,double d)//边入栈入栈即排序{{{
		{
			EDGE *p = new EDGE[1],*p2,*p3;
			p->n1 = n1;
			p->n2 = n2;
			p->d = d;
			
			if(!SE || d <= SE->d)
			{
				p->next = SE;
				SE = p;
				return;
			}

			p2 = SE;	
			while(d > p2->d)
			{
				p3 = p2;	
				p2 = p2->next;
				if(!p2) break;
			}

			p->next = p2;
			p3->next = p;
		}/*}}}*/

		void PopE()//边出栈{{{
		{
			EDGE *p = SE;
			if(!SE)
				return;
			SN = SN->next;
			delete(p);	
		}/*}}}*/

		void input()//定义输入函数,返回起始点{{{
		{
			int n1,n2;
			double d;
			cout << "please input::" << endl;
			while(true)
			{
				cin >> n1;
				if(n1 < 1)
					break;	
				cin >> n2;
				cin >> d;
				PushE(n1,n2,d);
				PushN(n1);
				PushN(n2);
			}	
		}/*}}}*/
		
		void find()//寻找最小生成树{{{
		{
			bool b = false;
			int an = 2,*np;
			MinTree ans;
			EDGE *p;
			input();
		
			//Prim	{{{
			ans.PushN(SE->n1);
			ans.PushN(SE->n2);

			p = SE->next;
			ans.PushE(SE->n1,SE->n2,SE->d);
			while(true)
			{
				if(ans.PushN(p->n1))
				{
					if(ans.PushN(p->n2))
					{
						b = true;
						ans.PopN();
						ans.PopN();
						p = p->next;
					}
					else
					{
						an++;
						ans.PushE(p->n1,p->n2,p->d);
						p = SE->next;
					}
				}
				else 
				{
					if(ans.PushN(p->n2))
					{
						an++;
						ans.PushE(p->n1,p->n2,p->d);
						p = SE->next;
					}
					else 
						p = p->next;
				}
				
				if(an >= n)
					break;


				if(!p)
				{
					if(b)
					{
						b = false;
						p = SE->next;
					}
					else
						cout << "No Reult" << endl;
					return;
				}
			}
					
			p = ans.SE;

			cout << "Prim::" << endl;
			while(p)
			{
				printf("%d %d %g\n",p->n1,p->n2,p->d);
				p = p->next;
			}/*}}}*/

	//Kruskal{{{
			ans.~MinTree();
			p = SE;
			np = new int[n];//标示该点属于哪一个森林
			for(int i = 0;i < n;i++)
				np[i] = i+1;
			

			while(p)
			{
				if(np[p->n1-1] != np[p->n2-1])
				{
					ans.PushE(p->n1,p->n2,p->d);
					for(int j = 0;j < n;j++)
						if(j != p->n2-1 && np[j] == np[p->n2-1])
							np[j] = np[p->n1-1],an--;
					np[p->n2-1] = np[p->n1-1];
				}
				p = p->next;
			}
			
			p = ans.SE;
			cout << "Kruskal::" << endl;
			while(p)
			{
				printf("%d %d %g\n",p->n1,p->n2,p->d);
				p = p->next;
			}/*}}}*/
			
			delete(np);
		}/*}}}*/ 
};/*}}}*/

int main(void)/*{{{*/
{
	MinTree MT;
	MT.find();
	return 0;
}/*}}}*/
