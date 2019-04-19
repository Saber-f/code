#include<iostream>
using namespace std;

int main(void)
{
	int a, b, r;
	cin >> a >> b >> r;
	a = (a/r) * (b/r);
	if(a == 0 || a % 2 == 0)
		cout << "The second one is winner.";
	else
		cout << "The first one is winner.";	
	return 0;
}

