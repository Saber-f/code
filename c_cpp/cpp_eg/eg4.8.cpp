//设置默认的参数值的函数
#include <iostream>
using namespace std;

void fun(int a = 1, int b = 3, int c = 5)
{
	cout << a << " " << b << " " << c << endl;
}

int main(void)
{
	fun();
	fun(7);
	fun(7,9);
	//fun(7,,11);
	fun(7,9,11);
	return 0;
}
