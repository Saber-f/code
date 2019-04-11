#include<iostream>
using namespace std;

int main(void)
{
	int n, u = 0, d = 0, r = 0, l = 0;
	char c;
	cin >> n;
	for(; n > 0; n--)
	{
		cin >> c;
		if(c == 'U')
			u++;
		else if(c == 'D')
			d++;
		else if(c == 'R')
			r++;
		else if(c == 'L')
			l++;
	}
	u = u > d ? d : u;
	r = r > l ? l : r;
	cout << 2 * (u+r);
	return 0;
}
