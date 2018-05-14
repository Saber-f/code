#include <iostream>
using namespace std;

class A
{
	public:
		A() {a = b = 0;}
		A(int i, int j) {a = i; a = j;}
		void copy(A &aa);
		void print() {cout << a << "," << b << endl;}
	private:
		int a, b;
};

void A::copy(A &aa)
{
	if(this == &aa) return;
	*this = aa;
}

int main(void)
{
	A a1,a2(3,4);
	a1.copy(a2);
	a1.copy(a2);
	a1.print();
	return 0;
}
