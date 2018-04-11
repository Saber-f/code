#include <iostream>
using namespace std;

int g = 5;
void f1(), f2();

int main(void)
{
    g = 10;
    f1();
    f2();
    cout << g << endl;
    return 0;
}

void f1()
{
    g = 15;
}

void f2()
{
    g = 20;
}