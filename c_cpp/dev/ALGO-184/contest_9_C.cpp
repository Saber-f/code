#include<iostream>
#include<stdio.h>
using namespace std;

int main(void)
{
	int n,*a,*b;//a/b 
	cin >> n;
	a = new int[n];
	b = new int[n];
	for(int i = 0; i < n; i++)
		cin >> a[i] >> b[i];
		
	//开始计算 
	long long ll;
	int s1,x1,x2,x3;//s1整数部分 
	n--;
	for(int f,t,g,i = 0; i < n; i++)
	{
		t = a[i]*a[i+1];
		g = b[i]*b[i+1];
		if(t < 0 && g > 0 || t > 0 && g < 0)
			f = 1;
		else
			f = 0;
		if(t < 0)
			t = -t;
		ll = t;
		if(g < 0)
			g = -g;
		s1 = t/g;
		ll = ll%g * 10000000;
		x1 = ll/g;
		ll = ll%g * 10000000;
		x2 = ll/g;		
		ll = ll%g * 1000000;
		x3 = ll/g;
		if(f)
			printf("-");
		printf("%d.%07d%07d%06d",s1,x1,x2,x3);
		if(i < n-1)
			printf("\n"); 
	}
	delete []a;
	delete []b;
	return 0;
}
