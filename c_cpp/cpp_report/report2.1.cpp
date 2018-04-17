//P154第三大题第一小题，解释cout的输出
#include <iostream>
#define N 5
using namespace std;

void fun();

int main(void)
{
    for(int i(1); i < N; i++)
        fun();
    return 0;
}

void fun()
{
    static int a;//默认初始值为0
    int b(2);
    cout << (a += 3, a + b) << endl;
}