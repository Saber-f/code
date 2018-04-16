//由于使用对参数求值顺序不同的编译器而产生二义性
#include <iostream>
using namespace std;

int add_int(int x, int y)
{
	return x + y;
}

int main(void)
{
	int x(4), y(6);
	int z = add_int(++x,x+y);
	cout << z << endl;
  return 0;
}
