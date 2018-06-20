//p338第四大题。
#include <iostream>
using namespace std;

class A
{
    public:
        A(int i = 0,int j = 0)
        {a1 = i;a2 = j;}
        void Print()
        {cout << a1+a2 << endl;}
    protected:
        int a1,a2;
};

class B:public A
{
    public: 
        B(int i = 0, int j = 0):A(i,j){}
        void Print()
        {cout << a1-a2 << endl;}
};

class C:public B 
{
    public: 
        C(int i = 0,int j = 0):B(i,j){}
        void Print()
        {cout << a1*a2 << endl;}
};

class D:public C
{
    public: 
        D(int i = 0, int j = 0):C(i,j){}
        void Print()
        {
            if(a2 != 0)
                cout << a1/a2 << endl;
            else
                cout << "divisor is zeros! \n" ;
        }
};

int main(void)
{
    int i(9),j = 3;
    A a(i,j);
    B b(i,j);
    C c(i,j);
    D d(i,j);
    A *m[4] = {&a,&b,&c,&d};
    for(int n(0);n < 4;n++)
        m[n]->Print();
    A &ra = c;
    ra.Print();
    A aa = c;  
    aa.Print();  
    return 0;
}