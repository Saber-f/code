#include<stdio.h>

int main(void)
{
	char c;
	int a,b,ans[100] = {0},i;
	for(i = 0; i < 100;)
	{
		scanf("%d %d%c",&a,&b,&c);
		ans[i] += a * b;
		if(c == '\n')
		{
			if(a == 0 && b == 0)
				break;
			else
				i++;
		}	
	}
	printf("%d",ans[0]);
	for(int j = 1; j < i; j++)
		printf("\n%d",ans[j]);
	return 0;
}
