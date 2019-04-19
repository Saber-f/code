#include<iostream>
using namespace std;

typedef struct node{
	int n,l;
	struct node *next;
}NODE;

void add(NODE **A, int a, int b, int k)
{
	static NODE *p;
	p = new NODE;
	p->n = b;
	p->l = k;
	p->next = 0;
	if(A[a])
		p->next = A[a];
	A[a] = p;
}

void find(NODE **A, int a, int b, int k, int l)
{
	node *p = A[a];
	while(p)
	{
		if(p->n == b)
			return l + p->l;
		else if(p->n != k)
		{
			int t = find(A,p->n,b,a,(p->l)+l);
			if(t)
				return t;
		}
		p = p->next;
	}
	return 0;
}

int main(void)
{
	int n,m,a,b,k,*x,*y,*z;
	NODE **A;
	cin >> n >> m;n++;
	A = new NODE*[n];
	x = new int[m]; y = new int[m]; z = new int[m];
	for(int i = 0; i < n; i++)
		A[i] = 0;
	for(int i = 2; i < n; i++)
	{
		cin >> a >> b >> k;
		add(A,a,b,k);
		add(A,b,a,k);
	}
	
	for(int i = 0; i < m; i++)
	{
		cin >> a >> b;
		
	}
	
	for(int i = 0; i < m; i++)
	{
		cout << B[i];
		if(i < m-1)
			cout << endl;
	}
	
	return 0;
}
