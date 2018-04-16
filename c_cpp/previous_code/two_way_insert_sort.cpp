#include<iostream>

#define N 20

using namespace std;

void sort(int A[])
{
	int B[N],i1,i2,t,j;
	i1 = i2 = 0;
	B[0] = A[0];
	for (int i = 1; i < N; i++)
	{
		if(A[i] >= B[i2])
		{
			B[++i2] = A[i];
		}
		else if (A[i] <= B[i1])
		{
			if (--i1 < 0)
				i1 = N - 1;
			B[i1] = A[i];
		}
		else
		{
			if (i1 > 0)
			{
				t = (i1 - N + i2) / 2;
				if (t < 0)
				{
					t = (N + t);
				}
			}
			else
				t = (i1 + i2) / 2;
			if (A[i] <= B[t])
			{
				if (t == 0)
					t = N;
				while (A[i] <= B[--t])
				{
					if (t == 0)
						t = N;
				}
				if (--i1 < 0)
					i1 = N - 1;
				j = i1;
				while (true)
				{
					if (j + 1 >= N)
					{
						B[N - 1] = B[0];
						j = 0;
					}
					else
					{
						B[j] = B[j + 1];
						j++;
					}
					if (j == t)
						break;
				}
				B[j] = A[i];
			}
			else
			{
				if (t == N - 1)
					t = -1;
				while (A[i] >= B[++t])
				{
					if (t == N - 1)
						t = -1;
				}
				for (j = ++i2; j != t; j--)
				{
					if (j == 0)
					{
						B[0] = B[N - 1];
						j = N;
					}
					else
					{
						B[j] = B[j - 1];
					}
				}
				B[t] = A[i];
			}
		}
	}
	for (int j = 0; j < N; j++)
	{
		A[j] = B[i1++];
		if (i1 == N)
			i1 = 0;
	}
}

int main(void)
{
	int A[N] = {78,4,87,-789,-87,7,78,1,-78,3,4,5,9,8,2,71,99,321,-789,777};
	sort(A);
	for (int i = 0; i < N; i++)
	{
		cout << A[i] << " ";
	}
	cout << endl;
	return 0;
}
