#include <iostream>
using namespace std;

class A
{
public:
	A(){}
	virtual void f()
	{
		cout << "A::f() called" << endl;
	}
};

class B :public A
{
public:
	B()
	{
		f();
	}
	void g()
	{
		f();
	}
};

class C :public B
{
public:
	C() {}
	virtual void f()
	{
		cout << "C::f() called." << endl;
	}
};

int main(void)
{
	C c;
	c.g();
	return 0;
}
