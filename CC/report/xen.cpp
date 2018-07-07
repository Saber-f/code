//快速幂模运算
#include <iostream>
//快速幂模运算
using namespace std;

int main(void)
{
    int x,e,n;//计算x^e%n
    int size = 0,e_ = 1,r=1;
    char *pc;
    cin >> x >> e >> n;
    cout << x << '^' << e << '%' << n << '=';
    while (e_ <= e)
        e_ *= 2,size++;
    pc = new char[size];
    for(int i = 0;i < size;i++)
    {
        e_ /= 2;
        if(e >= e_)
            pc[i] = '1',e -= e_;
        else
            pc[i] = '0';
    }
    for(int i = size-1;i >= 0;i--)
    {
        if(pc[i] == '1')
            r = ((long long)r*x) % n;
        x = (long long)x*x % n;
    }
    cout << r << endl;
    delete pc;
    return 0;
}