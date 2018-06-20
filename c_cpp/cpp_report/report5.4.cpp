//教材p293四大题
#include <iostream>
using namespace std;

class A
{
    public:
        A(int i) {a = i;}
        void f1() {cout << a << 'A' << endl;}    
    protected:
        int a;    
};

class B: public A
{
    public:
        B(int i, int j, int k):A(i),aa(j),b(k){}
        void f1() 
        {
            cout << a << endl;
            aa.f1();
            cout << b << 'B' << endl;
        }
    private:
        int b;
        A aa;
};

void fun(A &a)
{
    a.f1();

}

int main(void)
{
    A a(5);
    B b(3,5,7);
    a.f1();
    b.f1();
    fun(b);
    return 0;
}