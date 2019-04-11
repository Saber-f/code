#include<iostream>
#include<stdio.h>
using namespace std;

int main(void)
{
	char c;
	int t,n,k,a[26] = {0},b[26] = {0};
	cin >> n >> k;
	getchar();
	for(int i = 1;i <= n;i++)
	{
		c = getchar();
		t = c - 'A';
		if(a[t] == 0)
			a[t] = i;	 
		b[t] = i;
	} 
	for(int m,i = 1; i <= n; i++)
	{
		m = 0;
		for(int j = 0;j < 26; j++) 
			if(i >= a[j] && i <= b[j])
				m++;
		if(m > k)
		{
			cout << "YES";
			return 0;
		}
	}
	cout << "NO";
	return 0;
}
