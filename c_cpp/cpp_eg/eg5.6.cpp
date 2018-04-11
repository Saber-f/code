#include <iostream>
using namespace std;

class A
{
    public:
    A(int x,int y)
    {X = x; Y = y;}

    int a()
    {
        return X;
    }

    int b()
    {
        return Y;
    }

    int c();
    
    int d();

    private:
    int X, Y;
};

inline int A::c()
{
    return a() + b();
}

inline int A::d()
{
    return c();
}

int main(void)
{
    A m(3,5);
    int i = m.d();
    cout << "d() return:" << i << endl;
    return 0;
}