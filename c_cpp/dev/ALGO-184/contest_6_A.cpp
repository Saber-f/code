#include<stdio.h>

int main(void)
{
	int a[26] = {0},max = 0,t;
	char c;
	
	while(1)
	{
		scanf("%c",&c);
		if(c == '\n')
			break;
		t = c-'A';
		if(t >= 0 && t < 26)
		{
			a[t]++;
			if(a[t] > max)
				max = a[t]; 
		}
	}
	
	for(int k;max > 0; max--)
	{
		k = 0;
		for(int i = 0; i < 26; i++)
		{
			if(a[i] >= max)
			{
				for(int j = k; j < i; j++)
					printf(" ");
				k = i+1;
				printf("*");
			}
		}
		printf("\n");
	}
	for(int i = 0; i < 26; i++)
		printf("%c",'A'+i);
	return 0;
}
