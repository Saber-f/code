#include <iostream>
#define M 1.5
#define A(a) M*a
using namespace std;

int main(void)
{
     int x(5), y(6);
    cout << A(x + y) << endl;
    return 0;
}
