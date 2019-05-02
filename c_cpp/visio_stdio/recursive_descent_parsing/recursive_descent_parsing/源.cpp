#include <iostream>
#include <cstring>
#include <stdio.h>
using namespace std;



class A {
public:
	char c[10];

	void read()
	{
		//∂¡»Î
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


	void error()
	{
		cout << "F\n";
		//∂¡ÕÍ÷¡/n
		while (getchar() != '\n');
	}


	void H()
	{
		if (c[0] == 'i' && c[1] == 'd' && c[2] == '\0')
			read();
		else if (c[0] == '(' && c[1] == '\0')
		{
			read();
			E();
			if (c[0] == ')' && c[1] == '\0')
				read();
		}
		else
			error();
	}

	void Fp()
	{
		if (c[0] == '*' && c[1] == '*' && c[2] == '\0')
		{
			read();
			H();
			Fp();
		}
	}

	void F()
	{
		H();
		Fp();
	}

	void Tp()
	{
		if (((c[0] == '*' || c[0] == '/' || c[0] == '%') && c[1] == '\0') || (c[0] == '/' && c[1] == '/' && c[2] == '\0'))
		{
			read();
			F();
			Tp();
		}
	}

	void T()
	{
		F();
		Tp();
	}

	void Ep()
	{
		if ((c[0] == '+' || c[0] == '-') && c[1] == '\0')
		{
			read();
			T();
			Ep();

		}
	}

	void E()
	{
		T();
		Ep();
	}


};




int main(void)
{
	A *a = new A;
	while (1)
	{
		a->read();
		a->E();
		if (a->c[0] == '\0')
			break;
		if (a->c[0] == '#' && a->c[1] == '\0')
			cout << 'T' << endl;
		else
			a->error();
	}
	delete a;
	return 0;
}