#include<stdio.h>

int main(void)
{
	int n,m,num = 0;
	scanf("%d %d",&n,&m);
	for(int t,i =0; i < n; i++)
	{
		scanf("%d",&t);
		if(t%m == 0)
			num += t/m;
		else
			num += t/m + 1;	
	}
	if(num % 2 == 0)
		printf("%d",num /2);
	else
		printf("%d",(num+1)/2);
	return 0;
} 
