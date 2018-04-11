#include <iostream>
using namespace std;

int main(void)
{
	int a = 1;
	cout << a << endl;
	{
		int a = 2;
		cout << a << endl;
		{
			int a = 3;
			cout << a << endl;
		}
		cout << a << endl;
	}
	cout << a << endl;
	return 0;
}
