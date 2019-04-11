#include<iostream>
using namespace std;

int main(void)
{
	int n,*a,m,*a2;
	cin >> n;
	a = new int[n];
	for(int i = 0; i < n; i++)
		cin >> a[i];
	cin >> m;
	a2 = new int[m];
	for(int r,n1,n2,i = 0; i < m; i++)
	{
		cin >> n1 >> n2;
		r = a[n1-1];
		for(int j = n1; j < n2; j++)
		{
			if(r > a[j])
				r = r%a[j];
			if(r == 0)
				break;
		}
		a2[i] = r;
	}
	for(int i = 0; i < m-1; i++)
		cout << a2[i] << endl;
	cout << a2[m-1];
	delete []a;
	delete []a2;
	return 0;
}
