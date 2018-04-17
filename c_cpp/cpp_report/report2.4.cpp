//P157第三大题第九小题，将函数改为void swap(int &x,int y)，观察并解释输出结果
#include <iostream>
using namespace std;

void swap(int &, int);

int main(void)
{
    int a(5), b(8);
    cout << "a=" << a << ",b=" << b << endl;
    swap(a,b);
    cout << "a=" << a << ",b=" << b << endl;
    return 0;
}

void swap(int &x, int y)
{
    int temp;
    temp = x;
    x = y;
    y = temp;
}