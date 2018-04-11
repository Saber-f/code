#include <iostream>
using namespace std;

class A
{
public:
	virtual void f1()
	{
		cout << "A::f1() called." << endl;
	}
	void f2()
	{
		f1();
	}
};

class B :public A
{
public:
	void f1()
	{
		cout << "B::f1() called." << endl;
	}
	void f3()
	{
		A::f1();
	}
};

int main(void)
{
	B b;
	b.f2();
	b.f3();
	A &ra = b;
	ra.f2();
	A a = b;
	a.f2();
	return 0;
}
