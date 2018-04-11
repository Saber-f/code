//动态联编的例子

#include <iostream>
using namespace std;

class A
{
public:
	virtual void print(int x, int y)
	{
		cout << x << "," << y << endl;
	}
};

class B :public A
{
public:
	virtual void print(int x, float y)
	{
		cout << x << "," << y << endl;
	}
};

void show(A &a)
{
	a.print(3, 8);
	a.print(6, 5.9);
}

int main(void)
{
	B b;
	show(b);
	return 0;
}
