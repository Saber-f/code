//教材P195三大题第二小题
#include <iostream>
using namespace std;

class B
{
    public:
    B();
    B(int i, int j);
    void printb();
    
    private:
    int a, b;
};

class A 
{
    public:
    A();
    A(int i, int j);
    void printa();
    private:
    B c;
};

A::A(int i, int j):c(i,j){}

void A::printa()
{
    c.printb();
}

B::B(int i, int j)
{
    a = i;
    b = j;
}

void B::printb()
{
    cout << "a=" << a << ",b=" << b << endl;
}

int main(void)
{
    A m(7,9);
    m.printa();
    return 0;
}