#include<iostream>
#include<time.h>
#include<stdlib.h>

#define N 20

using namespace std;

void merge(int A[], int n1, int n2)
{
	int *B1,*B2,m,sb1,sb2;
	if (n1 == n2)
		return;
	merge(A, n1, (int)(n1 + n2) / 2);
	merge(A, (int)(n1 + n2) / 2 + 1, n2); 
	m = (int)(n1 + n2) / 2;
	/*
	while (n1 != m2 && m2 <= n2)
	{
		if (A[n1] <= A[m2])
		{
			n1++;
		}
		else
		{
			t = A[m2];
			for (int i = m2; i > n1; i--)
			{
				A[i] = A[i - 1];
			}
			A[n1] = t;
			n1++;
			m2++;
		}
	}*/
	sb1 = m - n1 + 1;
	sb2 = n2 - m;
	B1 = new int[sb1];
	B2 = new int[sb2];
	for (int i = 0,j = n1; i < sb1; i++,j++)
	{
		B1[i] = A[j];
	}
	for (int i = 0,j = m + 1; i < sb2; i++,j++)
	{
		B2[i] = A[j];
	}
	for (int i = n1,j = 0,k = 0; i <= n2; i++)
	{
		if (j < sb1 && (B1[j] <= B2[k] || k >= sb2))
		{
			A[i] = B1[j++];
		}
		else
		{
			A[i] = B2[k++];
		}
	}
	delete(B1);
	delete(B2);
}

void output(int A[])
{
	for (int i = 0; i < N; i++)
		cout << A[i] << " ";
	cout << endl;
}

int main(void)
{
	int A[N];
	srand((unsigned)time(NULL));
	for (int i = 0; i < N; i++)
		A[i] = rand() % (2 * N);
	output(A);
	merge(A, 0, N - 1);
	output(A);
	return 0;
}
