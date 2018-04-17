// 函数模板的使用
#include <iostream>
using namespace std;

template <class T>
T Max(T a, T b)
{
    return a > b ? a : b;
}


int main(void)
{
    int n1(8), n2(9);
    double m1(3.14), m2(3.15);
    char c1('m'), c2('n');
    cout << Max(n1,n2) << endl;
    cout << Max(m1,m2) << endl;
    cout << Max(c1,c2) << endl;
    return 0;
}
