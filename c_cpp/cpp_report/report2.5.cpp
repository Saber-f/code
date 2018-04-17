//5.解释P158第三大题第十小题的输出。
#include <iostream>
using namespace std;

int &f1(int n, int s[])
{
    int&m = s[n];
    return m;
}

int main(void)
{
    int s[] = {5, 4, 3, 2, 1, 0};
    f1(3, s) = 10;
    cout << f1(3, s) << endl;
    return 0;    
}
