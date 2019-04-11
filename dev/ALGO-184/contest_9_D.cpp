#include<iostream>
using namespace std;

int main(void)
{
	int n,*a,j = 0,k;
	cin >> n;
	a = new int[n];
	k = n-1;
	for(int t,i = 0; i < n; i++)//j奇数角标，k偶数角标 
	{
		cin >> t;
		if(t % 2 == 0)//如果是偶数
		{
			a[k] = t;
			for(int x = k; x < n-1; x++)
			{
				if(a[x] < a[x+1])
					a[x] += a[x+1], a[x+1] = a[x] - a[x+1], a[x] -= a[x+1];
				else
					break;
			}
			k--;
		} 
		else//如果是奇数 
		{
			a[j] = t;
			for(int x = j; x > 0; x--)
			{
				if(a[x] < a[x-1])
					a[x] += a[x-1], a[x-1] = a[x] - a[x-1], a[x] -= a[x-1];		
				else
					break;		
			}
			j++;
		}
	}
	k++; j--;
	
	for(;k < n; k++)
	{
		a[0] += a[k];
		for(int i = 0;i < j;i++)
		{
			if(a[i] > a[i+1])
				a[i] += a[i+1], a[i+1] = a[i] - a[i+1], a[i] -= a[i+1];
			else
				break;
		}	
	}
	cout << a[0];
	delete []a;
	return 0;
}
