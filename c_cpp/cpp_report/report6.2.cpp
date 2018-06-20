//p333 三大题第一小题。给出并解释结果。
#include <iostream>
using namespace std;

class B
{
    public:
    B(int i) {b = i+50;show();}
    B() {}
    virtual void show()
    {
         cout << "B::show() called." << b << endl;
    }
    protected:
    int b;
};

class D:public B
{
    public:
    D(int i):B(i) {d = i+100;show();}
    D() {}
    void show()
    {
        cout << "D::show() called." << d << endl;
    }
    protected:
    int d;
};

int main(void)
{
    D dl(108);
    return 0;
}