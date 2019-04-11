#include<iostream>
using namespace std;

int main(void)
{
	int n;
	cin >> n;
	if(n % 2 == 0)
		cout << n*n/2;
	else
		cout << (n-1)/2*n+n/2+1;
	return 0;
}
