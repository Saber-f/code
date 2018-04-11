#include<iostream>

using namespace std;

void test(int &n)
{
	n = n * n;
}

int main(void)
{
	void (*test2)(int &n);
	test2 = test;
	int  n = 3;
	test2(n);
	cout << n << endl;
	return 0;
}
