#include<iostream>
using namespace std;

int main(void)
{
	int n,q;
	char *s;
	cin >> n >> q;
	cin.get();
	s = new char[n+1];
	cin.getline(s,n+1);
	for(int f, i, j, k, z = 0; z < q; z++)
	{
		cin >> i >> j >> k;
		if(k == 0)//·ÇÔö
		{
			for(i-- , j--; i < j; i++)
			{
				f = 1;
				for(k = j ; k > i; k--)
				{
					if(s[k] > s[k-1])
					{
						s[k] += s[k-1], s[k-1] = s[k] - s[k-1], s[k] -= s[k-1];
						f = 0;
					}
				}
				if(f)
					break;
			}
		}
		else//·Ç¼õ 
		{
			for(i-- , j--; i < j; i++)
			{
				f = 1;
				for(k = j ; k > i; k--)
				{
					if(s[k] < s[k-1])
					{
						s[k] += s[k-1], s[k-1] = s[k] - s[k-1], s[k] -= s[k-1];
						f = 0;
					}
				}
				if(f)
					break;
			}
		}
	}
	cout << s;	
	return 0;
}
