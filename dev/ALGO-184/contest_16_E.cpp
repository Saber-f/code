#include<iostream>
using namespace std;

int main(void)
{
	int n, m, k, *ar;
	cin >> n >> m >> k;
	ar = new int[n];
	for(int i = 0; i < n; i++)
		cin >> ar[i];
	for(int a,b,i = 0; i < m; i++)
	{
		cin >> a >> b;
		for(int j = a-1; j < b; j++)
			if(ar[j] > k)
				ar[j]--;
	}
	char f = 1;
	for(int i = 0; i < n; i++)
		if(ar[i] <= k)
		{
			if(f == 0)
				cout << ' ';				
			cout << i+1;
			f = 0;
		}	
	if(f)
		cout << "Game Over";
	delete []ar;
	return 0;
}
