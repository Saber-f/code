#include <iostream>
#define MAX(a,b) (a) > (b) ? (a) : (b)
using namespace std;

int  main(void)
{
    int m(1), n(2), p(0), q;
    q = MAX(m,n+p) * 10;
    cout << q << endl;
    return 0;
}
