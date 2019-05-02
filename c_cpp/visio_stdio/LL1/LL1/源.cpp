#include <iostream>
#include <cstring>
#include <stdio.h>
using namespace std;

typedef struct stause {
	int use,all;
	char s[100][10];
}S;

void push(S &st, char c[10])//入栈
{
	if (st.use >= st.all)
	{
		cout << "error" << endl;
		return;
	}
	for (int i = 0; i < 10; i++)
		st.s[st.use][i] = c[i];
	st.use++;
}

void pop(S &st, char c[10])//出栈
{
	if (st.use <= 0)
	{
		cout << "error" << endl;
		return;
	}
	st.use--;
	for (int i = 0; i < 10; i++)
		c[i] = st.s[st.use][i];
	st.s[st.use][0] = '\0';
}

bool isVt(char c[10])
{
	if (!strcmp(c, "E") || !strcmp(c, "E'") || !strcmp(c, "T") || !strcmp(c, "T'") || !strcmp(c, "F") || !strcmp(c, "F'") || !strcmp(c, "H"))
		return false;
	return true;
}

void read(char c[10])
{
	//读入
	char ch;
	for (int i = 0; i < 10; i++)
	{
		ch = getchar();
		if (ch == ',' || ch == '\n')
		{
			c[i] = '\0';
			break;
		}
		c[i] = ch;
	}
}

void init_st(S &st)//初始化栈
{
	char c[10];
	st.use = 0;
	c[0] = '#'; c[1] = '\0';
	push(st, c);
	c[0] = 'E'; c[1] = '\0';
	push(st, c);
}

void error()
{
	cout << "F\n";
	//读完至/n
	while (getchar() != '\n');
}

bool M(S &st, char x[10], char c[10])//M表
{
	if (x[0] == 'E' && x[1] == '\0')
	{
		if ((c[0] == 'i' && c[1] == 'd' && c[2] == '\0') || (c[0] == '(' && c[1] == '\0'))
		{
			x[0] = 'E'; x[1] = '\''; x[2] = '\0'; push(st, x);
			x[0] = 'T', x[1] = '\0'; push(st, x);
			return true;
		}
	}
	else if (x[0] == 'E' && x[1] == '\'')
	{
		if ((c[0] == '+' || c[0] == '-') && c[1] == '\0')
		{
			x[0] = 'E'; x[1] = '\''; x[2] = '\0'; push(st, x);
			x[0] = 'T', x[1] = '\0'; push(st, x);
			push(st, c);
			return true;
		}
		else if ((c[0] == ')' || c[0] == '#') && c[1] == '\0')
			return true;
	}
	else if (x[0] == 'T' && x[1] == '\0')
	{
		if ((c[0] == 'i' && c[1] == 'd' && c[2] == '\0') || (c[0] == '(' && c[1] == '\0'))
		{
			x[0] = 'T'; x[1] = '\''; x[2] = '\0'; push(st, x);
			x[0] = 'F', x[1] = '\0'; push(st, x);
			return true;
		}
	}
	else if (x[0] == 'T' && x[1] == '\'')
	{
		if (((c[0] == '*' || c[0] == '/' || c[0] == '%') && c[1] == '\0') || (c[0] == '/' && c[1] == '/' && c[2] == '\0'))
		{
			x[0] = 'T'; x[1] = '\''; x[2] = '\0'; push(st, x);
			x[0] = 'F', x[1] = '\0'; push(st, x);
			push(st, c);
			return true;
		}
		else if ((c[0] == '+' || c[0] == '-' || c[0] == ')' || c[0] == '#') && c[1] == '\0')
			return true;
	}
	else if (x[0] == 'F' && x[1] == '\0')
	{
		if ((c[0] == 'i' && c[1] == 'd' && c[2] == '\0') || (c[0] == '(' && c[1] == '\0'))
		{
			x[0] = 'F'; x[1] = '\''; x[2] = '\0'; push(st, x);
			x[0] = 'H', x[1] = '\0'; push(st, x);
			return true;
		}
	}
	else if (x[0] == 'F' && x[1] == '\'')
	{
		if (c[0] == '*' && c[1] == '*' && c[2] == '\0')
		{
			x[0] = 'F'; x[1] = '\''; x[2] = '\0'; push(st, x);
			x[0] = 'H', x[1] = '\0'; push(st, x);
			push(st, c);
			return true;
		}
		else if (((c[0] == '+' || c[0] == '-' || c[0] == '*' || c[0] == '/' || c[0] == '%' || c[0] == ')' || c[0] == '#') && c[1] == '\0') || (c[0] == '/' && c[1] == '/' && c[2] == '\0'))
			return true;
	}
	else//Hes
	{
		if (c[0] == 'i' && c[1] == 'd' && c[2] == '\0')
		{
			push(st, c);
			return true;
		}
		else if (c[0] == '(' && c[1] == '\0')
		{
			x[0] = ')'; x[1] = '\0'; push(st, x);
			x[0] = 'E'; push(st, x);
			x[0] = '('; push(st, x);
			return true;
		}
	}
	return false;
}

int main(void)
{
	char c[10], x[10];
	S st; st.all = 100; st.use = 0;
	
	//开始
	while (1)
	{
		init_st(st);
		read(c);
		if (c[0] == '\0')
			break;
		while (1)
		{
			pop(st, x);//弹出
			if (isVt(x))//如果x是终结符
			{
				if (!strcmp(x, c))
				{
					x[0] = '#'; x[1] = '\0';
					if (strcmp(x, c))
						read(c);
					else
					{
						cout << "T" << endl;
						break;
					}
				}
				else
				{
					error();
					break;
				}

			}
			else
			{
				if (M(st, x, c));
				else
				{
					error();
					break;
				}
			}
		}
	}
	return 0;
}