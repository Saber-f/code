#include<iostream>
using namespace std;



int main(void)
{
	int n,n1,n2;
	char *cp,c,c1,c2 = 0;
	cin >> n;
	cp = new char[n];
	//�����һ��
	for(int i = 0; i < n; i++)
		cin >> cp[i];
	//����ڶ���
	for(int i = 0; i < n; i++)
	{
		cin >> c;
		c1 = 1;
		for(int j = 0;j < n; j++)
		{
			if(c == cp[j])
			{
				cp[j] -= 26;
				c1 = 0;
				break;
			}
		}
		if(c1)//�����һ����û��c
		{
			c2 = c;n2 = i+1;
		}	
	} 
	
	for(int i = 0; i < n; i++)
	{
		if(cp[i] < 'A')
			cp[i] += 26;
		else
		{
			c1 = cp[i];
			n1 = i+1;
		}
	}
		
	if(c2)//    ���ڵ�һ�Ż�ڶ���
	{
		for(int i = 0; i < n; i++)
		{
			cin >> c;
			if(c == c1)
				c2 = -c2;
			else if(c == c2)
				c1 = -c1;
		}
		//����ʣ�µģ���Ȼ�Ѿ��н���� 
		for(int i = 3; i < n; i++)
			for(int j = 0; j < n; j++)
				cin >> c;
		if(c2 < 0)
			cout << 2 << ' ' << n2 << ' ' << c1;
		else
			cout << 1 << ' ' << n1 << ' ' << c2;
	} 
	else//����û������1,2�� 
	{
		for(int i = 2; i < n; i++)
		{
			for(int k = 0; k < n; k++)
			{
				cin >> c;
				c1 = 1;
				for(int j = 0;j < n; j++)
				{
					if(c == cp[j])
					{
						cp[j] -= 26;
						c1 = 0;
						break;
					}
				}
				if(c1)//�����һ����û��c
				{
					c2 = c;n2 = k+1;n1 = i+1;
				}
			}
			for(int k = 0; k < n; k++)
			{
				if(cp[k] < 'A')
					cp[k] += 26;
				else
					c2 = cp[k];
			}	
		}
		cout << n1 << ' ' << n2 << ' ' << c2;		
	}	
	delete cp;
	return 0;
} 
