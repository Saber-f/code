//p286三大题第二小题
#include <iostream>
using namespace std;

class A
{
    public:
        A(int i, int j) {a = i,b = j;}
        void Move(int x, int y)  {a += x, b += y;}
        void Show() {cout << "(" << a << "," << b << ")" << endl;}

    private:
        int a, b;
};

class B:public A
{
    public:
        B(int i, int j, int k, int l):A(i,j),x(k),y(l) {}
        void Show() {cout << x << "," << y << endl;}
        void fun() {Move(3,5);}
        void f1() {A::Show();}
    private:
        int x, y;
};


int main(void)
{
    A e(1,2);
    e.Show();
    B d(3,4,5,6);
    d.fun();
    d.A::Show();
    d.B::Show();
    d.f1();
    return 0;
}