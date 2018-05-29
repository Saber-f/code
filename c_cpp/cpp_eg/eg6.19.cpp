#include <iostream>
using namespace std;

class A
{
    public:
        A() {m = 0;}
        void print()
        {
            cout << m << endl;
        }
        A operator=(int i);
    private:
    double m;
};

A A::operator=(int i)
{
    m = i;
    cout << "i = " << i << "  this::" << this << endl;
    return *this;
}

int main(void)
{
    A a;
    cout << "a::" << &a << endl;
    (a = 10) = 11;
    cout << "a::" << &a << endl;
    a.print();
    return 0;
}