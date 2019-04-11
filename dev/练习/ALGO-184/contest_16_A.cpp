#include<iostream>
using namespace std;

int main(void)
{
	char id[5] = {'A','D','F','G','X'},table[5][5],st[100];
	for(int i = 0; i < 5; i++)
		for(int j = 0; j < 5; j++)
		{
			cin >> table[i][j];
			if(table[i][j] == 'i')
				table[i][j] = 'j';
		}
	st[0] = cin.get();
	for(int i = 0;;i++)
	{
		st[i] = cin.get();
		if(st[i] == '\n')
			break;	
	}
	for(int i = 0;;i++)
	{
		if(st[i] == '\n')
			break;
		for(int j = 0; j < 5; j++)
			for(int k = 0; k < 5; k++)
				if(table[j][k] == st[i])
				{
					if(i > 0)
						cout << ' ';
					cout << id[j] << id[k];	
				}		
	}	
	return 0;
}
