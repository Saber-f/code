#include<iostream>
using namespace std;

int main(void)
{
	int H,b,w,n;
	cin >> H >> b >> w;
	if(H > b && b <= w)
		cout << -1;
	else
	{
		n = (H-b)/(b-w);
		if(n*(b-w)+b == H)
			cout << n+1;
		 else
		 	cout << n+2; 
	}	
	return 0;
}
