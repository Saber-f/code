#include<iostream>
using namespace std;

int main(void)
{
	int n,m,*P,*A;
	cin >> n >> m;
	A = new int[m];
	P = new int[m];
	for(int i = 0 ; i < m; i++)
	{	
		cin >> P[i] >> A[i];
		for(int j = i; j > 0; j--)
		{
			if(P[j] < P[j-1])
				P[j] += P[j-1],P[j-1] = P[j] - P[j-1],P[j] -= P[j-1],A[j] += A[j-1],A[j-1] = A[j] - A[j-1],A[j] -= A[j-1];
			else
				break;
		}
	}
	m = 0;
	for(int i = 0;;i++)
	{
		if(n > A[i])
		{
			m += P[i] * A[i];
			n -= A[i];
		}
		else
		{
			m += P[i] * n;
			cout << m;
			break;
		}		
	}	
	delete []A;
	delete []P;
	return 0;
}
