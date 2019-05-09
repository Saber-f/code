#include <iostream>
#include <cstring>
#include <stdio.h>
#define L 23
#define W 11
#define H 4
using namespace std;

//符号栈
typedef struct stause {
	int use, all;
	char s[100][10];
}S;

//状态栈
typedef struct sstause {
	int use, all;
	int s[100];
}SS;

void push(S& st, char c[10])//符号栈入栈
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

void push(SS& st, int n)//状态栈入栈
{
	if (st.use >= st.all)
	{
		cout << "error" << endl;
		return;
	}
	st.s[st.use] = n;
	st.use++;
}

void pop(S & st, char c[10])//符号栈出栈
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

int pop(SS& st)//状态栈出栈
{
	int n;
	if (st.use <= 0)
	{
		cout << "error" << endl;
		return -1;
	}
	st.use--;
	n = st.s[st.use];
	st.s[st.use] = -1;
	return n;
}

int pop_(SS& st)//状态栈出栈
{
	if (st.use <= 0)
	{
		cout << "error" << endl;
		return -1;
	}
	return st.s[st.use-1];
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

void init_st(S & st, SS & sst)//初始化栈
{
	char c[10];
	st.use = 0; st.all = 100;
	c[0] = '#'; c[1] = '\0';
	push(st, c);
	
	sst.s[0] = 0; sst.all = 100;
	sst.use = 1;	
}

void error()
{
	cout << "F\n";
	//读完至/n
	while (getchar() != '\n');
}

int T_num(char c[10])//终结符编号
{
	switch (c[0])
	{
	case 'E':
		return 0;
	case 'T':
		return 1;
	case 'F':
		return 2;
	case 'H':
		return 3;
	}
	return -1;
}

int N_num(char c[10])//非终结符编号
{
	switch (c[0])
	{
	case '+':
		if(c[1] == '\0')
			return 0;
	case '-':
		if (c[1] == '\0')
			return 1;
	case '*':
		if (c[1] == '*' && c[2] == '\0')
			return 6;
		else if(c[1] == '\0')
			return 2;
	case '/':
		if (c[1] == '/' && c[2] == '\0')
			return 5;
		else if (c[1] == '\0')
			return 3;
	case '%':
		if (c[1] == '\0')
			return 4;
	case '(':
		if (c[1] == '\0')
			return 7;
	case ')':
		if (c[1] == '\0')
			return 8;
	case 'i':
		if (c[1] == 'd' && c[2] =='\0')
			return 9;
	case '#':
		if (c[1] == '\0')
			return 10;
	}
	return -1;
}

void GOTO(int G[L][H], SS &sst, S &st, int n)//根据拓广文法G’(E’)规约
{
	char c[10];
	switch (n)
	{
	case -1:
		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != '+')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != 'E')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -2:
		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != '-')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != 'E')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -3:
		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		c[0] = 'E';

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -4:
		pop(st, c);
		if (c[0] != 'F')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != '*')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -5:
		pop(st, c);
		if (c[0] != 'F')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != '/' && c[1] == '\0')
		{
			pop(sst);			
		}
		else
		{
			error();
			return;
		}

		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -6:
		pop(st, c);
		if (c[0] != 'F')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != '%')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -7:
		pop(st, c);
		if (c[0] != 'F')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] == '/' && c[1] == '/')
		{
			pop(sst);
		}
		else
		{
			error();
			return;
		}

		pop(st, c);
		if (c[0] != 'T')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -8:
		pop(st, c);
		if (c[0] != 'F')
		{
			error();
			return;
		}
		else
			pop(sst);

		c[0] = 'T';

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -9:
		pop(st, c);
		if (c[0] != 'H')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] == '*' && c[1] == '*')
		{
			pop(sst);
		}
		else
		{
			error();
			return;
		}

		pop(st, c);
		if (c[0] != 'F')
		{
			error();
			return;
		}
		else
			pop(sst);

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -10:
		pop(st, c);
		if (c[0] != 'H')
		{
			error();
			return;
		}
		else
			pop(sst);

		c[0] = 'F';

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -11:
		pop(st, c);
		if (c[0] != ')')
		{
			error();
			return;
		}
		else
			pop(sst);

		pop(st, c);
		if (c[0] == 'E')
		{
			pop(sst);
		}
		else
		{
			error();
			return;
		}

		pop(st, c);
		if (c[0] != '(')
		{
			error();
			return;
		}
		else
			pop(sst);

		c[0] = 'H';
		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	case -12:
		pop(st, c);
		if (c[0] != 'i' || c[1] != 'd')
		{
			error();
			return;
		}
		else
			pop(sst);

		c[0] = 'H'; c[1] = '\0';

		push(sst, G[pop_(sst)][T_num(c)]);
		push(st, c);
		break;

	default:
		error();
	}
}

bool ACTION(int A[L][W], int G[L][H], S &st, SS &sst, char c[10])
{
	int n = pop_(sst), m = N_num(c);
	if (m == -1)
		n = 0;
	else
		n = A[n][m];//ACTION表
	if (n > 0)
	{
		push(sst, n);//状态n入栈
		push(st, c);//符号c入栈
		return true;
	}
	else if (n < 0)//规约
	{
		if (n == -9999)
			c[0] = '\0';
		else
			GOTO(G, sst, st, n);
		return false;
	}
	else
	{
		error();
		c[0] = -1;
		return false;
	}
}

int main(void)
{
	char c[10];
	int A[L][W] = {
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 7 , 8 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,-9999},
		{-3 ,-3 , 9 , 10, 11, 12,-3 ,-3 ,-3 ,-3 ,-3 },
		{-8 ,-8 ,-8 ,-8 ,-8 ,-8 , 13,-8 ,-8 ,-8 ,-8 },
		{-10,-10,-10,-10,-10,-10,-10,-10,-10,-10,-10},
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{-12,-12,-12,-12,-12,-12,-12,-12,-12,-12,-12},
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 0 , 0 , 0 , 0 , 0 , 0 , 0 , 5 , 0 , 6 , 0 },
		{ 7  ,8 , 0 , 0 , 0 , 0 , 0 , 0 , 22, 0 , 0 },
		{-1 ,-1 , 9 ,10 ,11 ,12 ,-1 ,-1 ,-1 ,-1 ,-1 },
		{-2 ,-2 , 9 ,10 ,11 ,12 ,-2 ,-2 ,-2 ,-2 ,-2 },
		{-4 ,-4 ,-4 ,-4 ,-4 ,-4 , 13,-4 ,-4 ,-4 ,-4 },
		{-5 ,-5 ,-5 ,-5 ,-5 ,-5 , 13,-5 ,-5 ,-5 ,-5 },
		{-6 ,-6 ,-6 ,-6 ,-6 ,-6 , 13,-6 ,-6 ,-6 ,-6 },
		{-7 ,-7 ,-7 ,-7 ,-7 ,-7 , 13,-7 ,-7 ,-7 ,-7 },
		{-9 ,-9 ,-9 ,-9 ,-9 ,-9 ,-9 ,-9 ,-9 ,-9 ,-9 },
		{-11,-11,-11,-11,-11,-11,-11,-11,-11,-11,-11}
		};
	int G[L][H] = {
		{1 ,2 ,3 ,4 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{14,2 ,3 ,4 },
		{0 ,0 ,0 ,0 },
		{0 ,15,3 ,4 },
		{0 ,16,3 ,4 },
		{0 ,0 ,17,4 },
		{0 ,0 ,18,4 },
		{0 ,0 ,19,4 },
		{0 ,0 ,20,4 },
		{0 ,0 ,0 ,21},
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 },
		{0 ,0 ,0 ,0 }
	};
	S st;
	SS sst;

	//开始
	while (1)
	{
		init_st(st,sst);
		read(c);
		if (c[0] == '\0')
			break;
		while (1)
		{
			if (ACTION(A, G, st, sst, c))
				read(c);
			else if (c[0] == '\0')
			{
				cout << 'T' << endl;
				break;
			}
			else if (c[0] == -1)
				break;
		}
	}
	return 0;
}
//id,*,id,**,id,#