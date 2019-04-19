#include<iostream>
using namespace std;

int main(void)
{
	int N,*arr;
	cin >> N;
	arr = new int[2*N];
	for(int i = 0; i < 2*N; i++)
		cin >> arr[i];
	
	
	
	delete arr;
	return 0;
}
