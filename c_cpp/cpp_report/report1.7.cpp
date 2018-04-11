#include <iostream>
using namespace std;

void fun(int &n)
{
    int a = (1<<4) - 1;
    n |= a;
}

int main(void)
{
    int n;
    while(true){
        cout << "please input a number::";
        cin >> n;
        if(n == 88520)
            break;
        fun(n);
        cout << n << endl;
    }
	return 0;
}
