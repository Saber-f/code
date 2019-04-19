#include<iostream>
using namespace std;

int f(int x, int y, int z, int a, int b, int c)
{
	if(a > b)//石头比布多 
	{
		if(a > c) //出的石头最多 
			return 3;
		else if(a < c)//出布的多
			return 2;
		else//出石头和布的一样多
		{
			if(x > z)
				return 1;
			else
				return 3;
		}		 
	}
	else if(a < b)//石头比布少
	{
		if(b > c)//剪刀比布多
			return 1;
		else if(b < c)//布最多
			return 2;
		else//剪刀和布一样多
		{
			if(y > z)
				return 2;
			else
				return 3;
		} 
	} 
	else//石头和布一样多
	{
		if(c > a)//出布的最多
			return 2;
		else if(a > c)//布最少 
		{
			if(x > y)
				return 1;
			else
				return 2;
		} 
		else//三个一样多
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
