#include <iostream>
#include <stdio.h>
using namespace std;

int main(void)
{
	int a[2][6], n = 0, t = 0;
	for(int i = 0; i < 2; i++)
		for(int j = 0; j < 6; j++)
			cin >> a[i][j];
	for(int i = 0; i < 6; i++)
		for(int j = 0; j < 6; j++)
		{
			if(a[0][i] > a[1][j])
				n++;
			else if(a[0][i] < a[1][j])
				t++;
		}
	printf("%.5f",(float)n/(n+t));
	return 0;
}
