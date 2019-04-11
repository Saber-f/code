#include<iostream>
using namespace std;

int main(void)
{
	int n;
	cin >> n;
	if(n == 2)
		cout << 3;
	else
		cout << 2*n-1 + 2 * (n-3); 
	return 0;
}
