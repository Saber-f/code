#include<iostream>
using namespace std;

int main(void)
{
	int n, m, *a, *b, num = 0;
	cin >> n >> m;
	a = new int[n];
	b = new int[n];
	for(int i = 0; i < n; i++)
	{
		cin >> a[i];
		b[i] = 0;
		for(int  j = 0; j < i; j++)
			if(a[i] > a[j])	
				b[i]++;
		if(b[i] >= m)
			num++;
		else
			b[i] = 0;
	}
	cout << num << endl;
	for(int i = 0; i < n; i++)
	{
		if(b[i])
		{
			num--;
			if(num)
				cout << i+1 << ' ';
			else
				cout << i+1; 
		} 
	}
	delete a;
	delete b;
	return 0;
}
