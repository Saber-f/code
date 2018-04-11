#include <iostream>
using namespace std;

int fun()
{
	return 2;
}

int main(void)
{
	int (*pfun)();
	pfun = fun;
	cout << pfun() << endl;
	return 0;
}
