#include<iostream>
using namespace std;

int main(void)
{
	int n,k;
	char ar[1001] = {0};
	cin >> n >> k;
	for(int i = 1; i <= k; i++)
		for(int j = 1; j <= n; j++)
			if(j % i == 0)
				ar[j] = ~ar[j];
	cout << 1;
	for(int i = 2; i <= n; i++)
		if(ar[i])
			cout << ' ' << i;			
	return 0;
}
