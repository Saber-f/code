#include<stdio.h>

void next(int *a, int *b)//下一分钟 
{
	(*b)++;
	if(*b == 60)
	{
		*b = 0;
		*a = (*a + 1) % 24;
	} 
}

int ish(int a, int b)//判断是否为回文 
{
	int c,d;
	c = b/10;
	d = b%10;
	b = d*10 + c;
	if(a == b)
		return 1;
	else
		return 0;
}


int main(void)
{
	int a,b;
	scanf("%d:%d",&a,&b);
	for(int i = 0;;i++)
	{
		if(ish(a,b))
		{
			printf("%d",i);
			break;
		}
		next(&a,&b);
	}
	return 0;
}
