#include<iostream>
using namespace std;

int main(void)
{
	int lx = 0,sy = 0,in,f = 0;
	for(int i = 0; i < 12; i++)
	{
		cin >> in;
		if(f == 0)
		{
			sy = 1000 + sy - in;
			if(sy < 0)
				f = -(i+1);
			while(sy >= 100)
			{
				sy -= 100;
				lx += 100;
			}
		}
	}
	if(f)
		cout << f;
	else
		cout << lx*1.2+sy;
	return 0;
}
