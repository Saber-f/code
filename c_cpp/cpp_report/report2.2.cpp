#include <iostream>
using namespace std;

int add(int a, int b);

int main(void)
{
    extern int x, y;
    cout << add(x, y) << endl;
    //int x(20), y(5);
    return 0;
}

//static int x(20), y(5);
int x(20), y(5);

int add(int a, int b)
{
    int s = a + b;
    return s;
}