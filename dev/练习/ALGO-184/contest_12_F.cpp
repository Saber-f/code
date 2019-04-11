#include<stdio.h>

int main(void)
{
	int n;
	char c,s[120] = {0};
	while(1)
	{
		scanf("%d",&n);
		if(n == 0)
			break;
		scanf(",%c",&c);
		if(n > 0)//·Å¿§·È
		{
			for(int i = 0; i < 120; i++)
			{
				if(s[i] == 0)
					s[i] = c,n--;
				if(n == 0)
					break;
			}
		} 
		else//ºÈ¿§·È 
		{
			for(int i = 0; i < 120; i++)
			{
				if(s[i] == c)
					s[i] = 0,n++;
				if(n == 0)
					break;
			}	
		}	
	}
	for(int j = 0,i = 0; i < 120; i++)
	{
		if(s[i] != 0)
		{
			for(int k = j; j < i; j++)
				printf("  ");
			if(i == 0)
				printf("%c",s[i]);
			else
				printf(" %c",s[i]);
			j = i+1;
		}
	}
	return 0;
}
