#include <iostream>
using namespace std;

class A
{
	public:
		A(int i, double j) {a = i; b = j;}
		void p() {cout << a << ',' << b << endl;}
		A operator+(const A &a)
		{
			A c(this->a+a.a,this->b+b.b );
			c.a = this->a + a.a;
			c.b = this->b + a.b;
			return c;
		}
	private: 
		int a;
		double b;
};

int main(void)
{
		
	return 0;
}
