//p335 三大题第三小题。给出并解释结果。
#include <iostream>
using namespace std;

class A
{
    public:
        A() {ver = 'A';}
        void print() {cout << "The A version" << ver << endl;}
    protected:
        char ver;
};

class D1:public A
{
    public:
        D1(int number) {info = number; ver = '1';}
        void print()
        {cout << "The D1 info:" << info << "version" << ver << endl;}
    private:
        int info;
};

class D2:public A
{
    public:
        D2(int number) {info = number;}
        void print()
        {cout << "The D2 info:" << info << "version" << ver << endl;}
    private:
        int info;
};

class D3:public D1
{
    public: 
        D3(int number):D1(number)
        {
            info = number;
            ver = '3';
        }
        void print()
        {cout << "The D3 info:" << info << "version" << ver << endl;}
    private: 
        int info;
};

void print_info(A *p)
{
    p->print();
}

int main(void)
{
    A a;
    D1 d1(4);
    D2 d2(100);
    D3 d3(-25);
    print_info(&a);
    print_info(&d1);
    print_info(&d2);
    print_info(&d3);
    return 0;
}