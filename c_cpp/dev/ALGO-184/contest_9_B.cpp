#include<iostream>
using namespace std;

int main(void)
{
	int a[8];
	for(int i = 0; i < 8; i++)
	{
		cin >> a[i];
		for(int j = i; j > 0; j--)
			if(a[j] < a[j-1])
				a[j] += a[j-1], a[j-1] = a[j] - a[j-1], a[j] -= a[j-1];
	}
	for(int i = 0; i < 4; i++)
	{
		a[i] += a[7-i]; 
		for(int j = i; j > 0; j--)
			if(a[j] < a[j-1])
				a[j] += a[j-1], a[j-1] = a[j] - a[j-1], a[j] -= a[j-1];
	}
	if(a[0] + a[3] == a[1] + a[2])
		cout << "YES";
	else
		cout << "NO";
	
	return 0;
}
