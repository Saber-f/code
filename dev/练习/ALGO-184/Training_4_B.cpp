#include<stdio.h>

void add(char s1[10000][21], char s2[10000][21], char s[21], char t[21], int n)
{
	for(int i = 1;; i+=i)
	{
		if(s2[n][0] == '\000')
		{
			for(int j = 0; j <= t[0]; j++)
				s2[n][j] = t[j];
			for(int j = 0; j <= s[0]; j++)
			    s1[n][j] = s[j];
			break;		
		}
		n += i;
	}	
}

int find(char s1[10000][21], char s2[10000][21], char s[21], int n)
{
	char f;
	for(int i = 1;; i+=i)
	{
		if(s2[n][0] == '\000')
		{
			return -1;
		}
		else if(s[0] = s2[n][0])
		{
			f = 1;
			for(int j = 1; j <= s[0]; j++)
			{
				if(s[j] != s2[n][j])
				{
					f = 0;
					break;
				}
			}
			if(f)
				break;
		}
		n += i;
	}	
	return n%10000;
}


int main(void)
{
	int n,an[10000];
	char s1[10000][21],s2[10000][21],s[21],t[21];
	while(1)
	{
		scanf("%c",&s[1]);
		if(s[1] == '\n')
			break;
		for(int i = 2;;i++)
		{
			scanf("%c",&s[i]);
			if(s[i] == ' ')
			{
				s[0] = i-1;
				break;
			}
		}
		
		n = 1;
		for(int i = 1;;i++)
		{
			scanf("%c",&t[i]);
			if(t[i] == '\n')
			{
				t[0] = i-1;
				break;
			}
			n = n*t[i] % 10000;
		}
		add(s1,s2,s,t,n);
	}
	
	//¿ªÊ¼·­Òë
	an[0] = 0;
	while(1)
	{
		scanf("%c",&t[1]);
		if(t[1] == '\n')
			break;
		n = t[1];
		for(int i = 2;;i++)
		{
			scanf("%c",&t[i]);
			if(t[i] == '\n')
			{
				t[0] = i-1;
				break;
			}
			n = n*t[i] % 10000;
		}
		an[++an[0]] = find(s1,s2,t,n);	
	} 
	
	for(int i = 1; i < an[0]; i++)
	{
		if(an[i] == -1)
			printf("meizhaodao");
		else
			for(int j = 1; j <= s1[an[i]][0]; j++)
				printf("%c",s1[an[i]][j]);
		printf("\n");
	}
	
	if(s1[an[an[0]]][0] == -1)
		printf("meizhaodao");
	else
		for(int j = 1; j <= s1[an[an[0]]][0]; j++)
			printf("%c",s1[an[an[0]]][j]);
	return 0;
}
