#include <iostream>
using namespace std;

class A
{
	public:
		A(int i) {a = i;}
		int fun(int b) {return a*c+b;}
		int c;
	private:
		int a;
};

int main(void)
{
	A x(8);
	int A::*pc;
	pc = &A::c;
	x.*pc = 3;
	int (A::*pfun)(int);
	pfun = &A::fun;      //good
	A *p = &x;
	cout << (p->*pfun)(5) << endl;
	return 0;
}
