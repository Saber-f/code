#include<iostream>
using namespace std;

int f(int x, int y, int z, int a, int b, int c)
{
	if(a > b)//ʯͷ�Ȳ��� 
	{
		if(a > c) //����ʯͷ��� 
			return 3;
		else if(a < c)//�����Ķ�
			return 2;
		else//��ʯͷ�Ͳ���һ����
		{
			if(x > z)
				return 1;
			else
				return 3;
		}		 
	}
	else if(a < b)//ʯͷ�Ȳ���
	{
		if(b > c)//�����Ȳ���
			return 1;
		else if(b < c)//�����
			return 2;
		else//�����Ͳ�һ����
		{
			if(y > z)
				return 2;
			else
				return 3;
		} 
	} 
	else//ʯͷ�Ͳ�һ����
	{
		if(c > a)//���������
			return 2;
		else if(a > c)//������ 
		{
			if(x > y)
				return 1;
			else
				return 2;
		} 
		else//����һ����
		{
			if(x > y && x > z)
				return 1;
			else if(y > z)
				return 2;
			else
				return 3;
		} 
	} 
}


int main(void)
{
	int x,y,z,a = 0, b = 0, c = 0;
	cin >> x >> y >> z;
	for(int t,i = 0; i < 100; i++)
	{
		t = f(x,y,z,a,b,c);
		if(i < 10)
		{
			if(t > 1)
				t--;
			else
				t = 3; 
		} 
		cout << t;
		if(i < 99)
			cout << endl;
		if(t == 1)
			a++;
		else if(t == 2)
			b++;
		else
			c++;			
	}
	
	
	
	
	return 0;
}
