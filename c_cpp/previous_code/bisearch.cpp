#include <iostream>
#include<stdlib.h>
#include<time.h>

#define N 100

using namespace std;

void fast(int A[], int n1, int n2)
{
	int t = A[n1], m1 = n1, m2 = n2;
	if (m1 >= m2)
		return;
	while (m1 < m2)
	{
		while (m1 < m2)
		{
			if (A[m2--] < t)
			{
				A[m1++] = A[++m2];
				break;
			}
		}
		while (m1 < m2)
		{
			if (A[m1++] > t)
			{
				A[m2--] = A[--m1];

							break;}		}	}

	A[m1] = t;
	fast(A, n1, m1 - 1);
	
fast(A, m1 + 1, n2);
}

void output(int A[])
{
	for (int i = 0; i < N; i++)
		cout << A[i] << " ";
	cout << endl;
}

void output2(int A[], int i)
{
	cout << "所在角标::";
	cout << i << " ";
	for (int j = i + 1; A[j] == A[i]; j++)
	{
		cout << j << " ";
	}
	for (int j = i - 1; A[j] == A[i]; j--)
	{
		cout << j << " ";
	}
	cout << endl;
}

void search(int A[], int n1, int n2, int n)
{
	int i = (n1 + n2) / 2;
	if (n1 > n2)
		cout << "don't there" << endl;
	else if (A[i] == n)
	{
		output2(A, i);
		return;
	}
	else if (n < A[i])
	{
		search(A, n1, i - 1, n);
	}
	else
		search(A, i + 1, n2, n);
}

int main(void)
{
	int A[N], n = 0;
	srand((unsigned)time(NULL));
	for (int i = 0;i < N;i++)
	{
		A[i] = rand() % N;
	}
	cout << " original data::" ;
	fast(A, 0, N - 1);
	output(A);
	cout << endl << "please input the data which you want to search(number < 0 to over)" << endl;
	while (true)
	{
		cin >> n;
		if (n < 0)
			break;
		search(A, 0,N - 1,n);
	}
	return 0;
}
