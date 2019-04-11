#include<stdio.h>

long long myf(int a,int b)
{
	static int ar[40];
	long long ans = 1;
	if(a-b < b)
		b = a-b;
	for(int i = 0; i < b; i++)
		ar[i] = a-i;
	for(int k = 1,i = b; i > 1; i--)
	{
		for(int j = 0; j < b; j++)
		{
			if(ar[j] % i == 0)
			{
				ar[j] /= i;
				k = 0;
				break;
			}
		}
		if(k)
			printf("error!");
	}
	for(int i = 0; i < b; i++)
		ans = ans * ar[i];
	return ans;
}


int main(void)
{
	char c1,c2,f = 1;
	int a = 0,b = 0;
	long long an[100];
	an[0] = 0;
	while(1)
	{
		scanf("%c",&c2);
		if(c2 == '\n')
		{
			if(c1 == '\n')
				break;
			else
			{
				an[0]++;
				an[an[0]] = 1;
				if(a > b)
					a = a - b - 1;
				else
					a = b - a - 1;
				b = 1;
				while(a >= b)
				{
					an[an[0]] += myf(a,b);
					a--;
					b++;
				}
				f = 1;
				a = 0;
				b = 0;
			}
		}
		else if(c2 == ' ')
		{
			f = 0;
		}
		else if(f)
		{
			a = a * 10 + (c2-'0');	
		}
		else
		{
			b = b * 10 + (c2-'0');
		}
		c1 = c2;
	}
	for(int i = 1; i < an[0]; i++)
		printf("%lld\n",an[i]);
	printf("%lld",an[an[0]]);
	return 0;
} 
