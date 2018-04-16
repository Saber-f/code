#include <iostream>
using namespace std;

int main(void)
{
    long long ln = 1, sum = 0;
    for(int i = 1; i <= 10; i++)
    {
        ln *= i;
        sum += ln;
    }
    cout << sum << endl;
    return 0;
}
