// P247三大题第一小题
#include <iostream>
using namespace std;

class A
{
    public:
    A();
    A(int i,int j);
    ~A();
    void Set(int i, int j) {a = i;b = j;}
    private:
    int a,b;
};

A::A()
{
    a = 0;
    b = 0;
    cout << "Default constructor called." << endl;
}

A::A(int i,int j)
{
    a = i;
    b = j;
    cout << "Constructor: a=" << a << ",b=" << b << endl;
}

A::~A()
{
    cout << "Destructor called. a=" << a << ",b=" << b << endl;
}

int main(void)
{
    void (A::*Set_p)(int ,int) = &A::Set;
    cout << "Starting1..." << endl;
    A a[3];
    for(int i = 0; i < 3; i++)
        (a[i].*Set_p)(2*i+1,(i+1)*2);
    cout << "Ending1..." << endl;
    cout << "Starting1..." << endl;
    A b[3] = {A(1,2),A(3,4),A(5,6)};
    cout << "Ending2..." << endl;
    return 0;
}