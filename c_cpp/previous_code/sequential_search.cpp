#include<iostream>
#include<stdlib.h>
#include<time.h>

#define N 100
#define M 10

using namespace std;

 void search(int A[],int n)
{
	for (int i = 0; i < N; i++)
	{
		if (A[i] == n)
		{
			cout << i << " ";
		}
	}
	cout << endl;
}

int main(void)
{
	int A[N],B[M];
	srand((unsigned)time(NULL));
	for (int i = 0; i < N; i++)
	{
		A[i] = rand() % N;
	}
	
	for (int i = 0; i < M; i++)
		B[i] = rand() % N;

	cout << "A::";

	for (int i = 0; i < N; i++)
	{
		cout << A[i] << " ";
	}
	cout << endl;

	cout << "B::";

	for (int i = 0; i < M; i++)
	{
		cout << B[i] << " ";
	}
	cout << endl;

	cout << "search::" << endl;

	for (int i = 0; i < M; i++)
	{
		cout << B[i] << "->";
		search(A, B[i]);
	}
	return 0;
}
