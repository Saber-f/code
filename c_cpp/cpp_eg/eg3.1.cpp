#include <iostream>
using namespace std;

#define A -10

int main(void)
{
# if A > 0
    cout << "a > 0" << endl;
# elif A < 0
    cout << "a < 0" << endl;
# else
    cout << "a == 0" << endl;
# endif
    return 0;
}
