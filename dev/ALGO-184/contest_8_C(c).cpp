#include<stdio.h>

int main(void)
{
	int n;
	scanf("%d",&n);
	for(int i = 1;;i++)
	{
		if(n > i)
			n -= i;
		else
		{
			if(i % 2 == 0)
				printf("%d/%d",n,i+1-n);
			else
				printf("%d/%d",i+1-n,n);
			break;
		}
	}
	return 0;
}
