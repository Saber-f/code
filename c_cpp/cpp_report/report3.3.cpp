// P194 3(1)
#include <iostream>
using namespace std;

class A
{
    public:
        A();
        A(int i, int j);
        void print();
    private:
        int a, b;
};

A::A()
{
    a = b = 0;
    cout << "Default constructor called.\n" ;
}

A::A(int i, int j)
{
    a = i;
    b = j;
    cout << "Constructor called.\n";
}

void A::print()
{
    cout << "a=" << a << ",b=" << b << endl;
}

int main(void)
{
    A m, n(4,8);
    m.print();
    n.print();
    return 0;
} 