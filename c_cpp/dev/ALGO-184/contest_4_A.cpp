#include<iostream>
using namespace std;

int main()
{
	int n,k;
	cin >> n >> k;
	int *sc = new int[n];
	for(int i = 0; i < n;i++)
		cin >> sc[i];
	
	if(k > n-2)
		cout << n;
	else
	{
		int t,w = 0;
		while(1)
		{
			if(sc[0] > sc[1])
			{
				t = sc[1];
				w++;
			}
			else
			{
				t = sc[0];
				sc[0] = sc[1];
				w = 1;
			}
			
			if(w == k)
			{
				cout << sc[0];
				break;
			}
			
			for(int i = 2; i < n; i++)
			{
				sc[i-1] = sc[i];
			}
			sc[n-1] = t;	
		}
	}
	return 0;
} 
