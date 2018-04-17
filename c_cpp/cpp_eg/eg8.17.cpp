//虚构析函数的例子
#include <iostream>
using namespace std;

class A
{
public:
	virtual ~A() { cout << "A::~A() called." << endl; }
};

class B :public A
{
private:
	char *buf;

public:
	B(int i) { buf = new char[i]; }
	~B()
	{
		delete buf;
		cout << "B::~B() called." << endl;
	}
};

void fun(A *a)
{
	delete a;
}

int main(void)
{
	A *a = new B(15);
	fun(a);
	return 0;
}
