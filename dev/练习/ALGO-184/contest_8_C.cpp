#include<iostream>
using namespace std;

int main(void)
{
	int n;
	cin >> n;
	for(int i = 1;;i++)
	{
		if(n > i)
			n -= i;
		else
		{
			if(i % 2 == 0)
				cout << n << '/' << i+1-n;
			else
				cout << i+1-n << '/' << n;
			break;
		}
	}
	return 0;
}
