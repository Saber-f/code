//P248三大题第二小题
#include <iostream>
using namespace std;

class B
{
    public:
    B();
    B(int i);
    B(int i,int j);
    ~B();
    void print();
    private:
    int x,y;
};
B::B()
{
    x = y = 0;
    cout << "Default constructor called." << endl;
}

B::B(int i)
{
    x = i;
    y = 0;
    cout << "Constructor1 called." << endl;
}

B::B(int i,int j)
{
    x = i;
    y = j;
    cout << "Constructor2 called." << endl;
}

B::~B()
{
    cout << "Destructor called." << endl;
}

void B::print()
{
    cout << "x=" << x << ",y=" << y << endl;
}

int main(void)
{
    B *ptr;
    ptr = new B[3];
    ptr[0] = B();
    ptr[1] = B(5);
    ptr[2] = B(2,3);
    for(int i = 0; i < 3; i++)
        ptr[i].print();
    delete[] ptr;
    return 0;
}