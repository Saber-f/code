#include<iostream>
using namespace std;

int main(void)
{
	int N,K,a;
	a = 1;
	cin >> N >> K;
	for(int i = 0; i < N; i++)
	{
		if(a < K)
			a *= 2;
		else
			a += K;
	}
	cout << a;
	return 0;
}
