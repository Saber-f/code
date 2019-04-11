#include<iostream>
using namespace std;

int main(void)
{	
	int n,m,a,b;
	cin >> n;
	m = n;
	for(int i = 0; i < n; i++)
	{
		cin >> a >> b;
		m += b - a;
	}
	cout << m;
	return 0;
}
