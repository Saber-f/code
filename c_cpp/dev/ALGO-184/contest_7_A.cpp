#include<iostream>
using namespace std;

int main(void)
{
	int n,*a,*b,sc,sc_ = 0;
	cin >> n;
	a = new int[n];
	b = new int[n];
	cin >> a[0]; 
	for(int i = 1; i < n; i++)
	{
		cin >> a[i];
		for(int j = i; j > 0; j--)
		{
			if(a[j] > a[j-1])
			{
				a[j] += a[j-1];
				a[j-1] = a[j] - a[j-1];
				a[j] -= a[j-1]; 
			}
			else
				break;
		}
	} 
	cin >> b[0]; 
	for(int i = 1; i < n; i++)
	{
		cin >> b[i];
		for(int j = i; j > 0; j--)
		{
			if(b[j] > b[j-1])
			{
				b[j] += b[j-1];
				b[j-1] = b[j] - b[j-1];
				b[j] -= b[j-1]; 
			}
			else
				break;
		}
	} 
	for(int i = 0; i < n; i++)
	{
		sc = 0;
		for(int j = 0; j < n; j++)
		{
			if(a[(j+i)%n] > b[j])
				sc++;
			else if(a[j+i%n] < b[j])
				sc--;
		}
		if(sc > sc_)
			sc_ = sc; 
	}
	cout << sc_;
	return 0;
}
