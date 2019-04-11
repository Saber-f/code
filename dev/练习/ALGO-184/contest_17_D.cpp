#include<stdio.h>
#include<iostream>
#include<iomanip>
#include<math.h>
using namespace std;

int main(void)
{	
	int n,*a,flage = 1,beg = -1;
	double all = 1,l,t,t1,t2;
	cin >> n >> l >> t;
	a = new int[n];
	cin >> t1;
	a[n-1] = t1;
	for(int i = 0; i < n; i++)
	{
		if(i < n-1)
		{
			cin >> t2;
			t1 = t2 - t1;
		}
		else
		{
			t1 = a[i] + (l - t1);	
		}
		if(t1 <= 2*t)
		{
			a[i] = 1;
			if(!flage && beg < 0)
				beg = i;
		}
		else
		{
			a[i] = 0;
			flage = 0;
		}
		t1 = t2;
	}
	
	if(flage)//全为一
		printf("%0.10f",1 - 2/pow(2,n)); 
	else
	{
		if(beg < 0)
		{
			beg = 0;
			if(a[0] == 0)
			{
				printf("0.0000000000");				
				delete a;
				return 0;
			}
		}
		int t = 1,t2 = 4;
		for(int i = 1; i < n; i++)
		{
			if(a[++beg%n] == 1)
			{
				t++;
				t2 *= 2;
			}
			else if(t)
			{
				all *= (double)(t+2)/t2;//不撞车的概率 
				t = 0;
				t2 = 2;
			}
		}
		printf("%-.10f",1-all);
	}
	delete a;
	return 0;
}
