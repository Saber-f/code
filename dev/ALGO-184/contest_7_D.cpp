#include<iostream>
using namespace std;

int main(void)
{
	int n,m,t;
	cin >> n >> m;
	for(int i = 0 ; i < n; i++)
	{
		cin >> t;
		m -= t;
	}
	if(m > 0)
		cout << "NO";
	else
		cout << "YES";
	return 0;
}
