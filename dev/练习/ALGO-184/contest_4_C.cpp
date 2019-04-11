#include<iostream>
using namespace std;

int main(void)
{
	int a,b,c,d;
	float f;
	cin >> a >> b >> c >> d;
	if (a != b && a != c)
		cout << "A";
	else if(b != c && b != d)
		cout << "B";
	else if(c != a && c != d)
		cout << "C";
	else
		cout << "D";
	return 0;
}
