#include<iostream>
using namespace std;

int main(void)
{
	int n,a,b,c;
	cin >> n >> a >> b >> c;
	if(a < b)
	{
		if(c < a)
		{
			if(n > 1)
			{
				cout << a + c*(n-2);
			}
			else
			{
				cout << 0;
			}
		}
		else
		{
			cout << a*(n-1);
		}
	}
	else
	{
		if(c < b)
		{
			if(n > 1)
			{
				cout << b + c*(n-2);
			}
			else
			{
				cout << 0;
			}
		}
		else
		{
			cout << b*(n-1);
		}
	}	
	return 0;
}
