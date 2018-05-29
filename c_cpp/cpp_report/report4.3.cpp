    printf("tttt")
#include <iostream>
using namespace std;

class A
{
    public:
        A(int i = 0){m = i;cout << "constructor called." << m << "\n";}
        void Set(int i) {m = i;}
        void Print() const {cout << m << endl;}
        ~A() {cout << "destructor called." << m << "\n";}
    private:
        int m;
};

void fun(const A& c)
{
    c.Print();    
}

int main(void)
{
    fun(5);
    return 0;
}