#include <iostream>
#include <typeinfo>
using namespace std;

int main(void)
{
    typedef char *CHARP;
    typedef char STRING[81];
    CHARP p1;
    STRING s1;
    cout << typeid(p1).name() << endl;
    cout << typeid(s1).name() << endl;
    return 0;
}
