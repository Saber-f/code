#include <iostream>
using namespace std;

class A;

class B
{
	public:
		void y(A A);
};

class A
{
	public:
		void f(){cout << "hello" << endl;}
};

void B::y(A A)
{
	A.f();
}

int main()
{
	A a;
	B b;
	b.y(a);
}
