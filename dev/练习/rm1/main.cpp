#include <iostream>
using namespace std;

int main(void)
{
	int n;
	cin >> n;
	if (n < 3)
		cout << 1;
	else
	{
		int f1 = 1,f2 = 1,f3;
		for(int i = 2; i < n; i++)
		{
			f3 = (f1+f2)%10007;
			f1 = f2;
			f2 = f3;
		}
		cout << f3;
	}

	return 0;	
}
