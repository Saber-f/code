#include<iostream>
using namespace std;


int main(void)
{
	int m,n,s = 1;
	char a[100][100];
	cin >> n >> m;
	for(int i = 0; i < n; i++)
		for(int j = 0; j < m; j++)
			cin >> a[i][j];
	for(int i = 0; i < n; i++)
		for(int j = 0; j < m; j++)
		{
			if(a[i][j] == '1')
			{
				for(int x = i; x < n; x++)
					for(int y = j; y < m; y++)
						a[x][y] = a[x][y] == '1' ? '0' : '1';
				s = s == 1 ? 2 : 1;
			}
		}
	if(s == 2)
		cout << 'A';
	else
		cout << 'B';
	return 0;
}

