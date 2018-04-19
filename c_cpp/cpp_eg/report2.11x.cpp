//jin tai cheng yuan hanshu /bian liang
#include <iostream>
using namespace std;

class A
{
    public:
        A(){N = 0;}

        /*static void f1(void)
        {
            static int i(0);
            i++;
            cout << i << endl;
        }*/

        void f2(void)
        {
            static int i(0);
            i++;
            cout << i << endl;
        }
    private:
        int N;
};

int main(void)
{
    A a1,a2;
    /*a1.f1();
    A::f1();
    a2.f1();*/
    a1.f2();
    a2.f2();
    a1.f2();
    a2.f2();


    return 0;
}
