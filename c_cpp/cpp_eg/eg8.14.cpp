#include <iostream>
using namespace std;

class A
{
public:
	virtual void f()
	{
		cout << "A::f() called." << endl;
	}
};

class B :public A
{
public:
	void f()
	{
		cout << "B::f() called" << endl;
	}
};

int main(void)
{
	B b;
	A &r = b;
	void (A::*pf)() = &A::f;
	(r.*pf)();
	return 0;
}
