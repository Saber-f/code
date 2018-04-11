#include <iostream>

using namespace std;

void fast(int A[], int n1, int n2)
{
	int t = A[n1],m1 = n1,m2 = n2;
	if (m1 >= m2)
		return;
	while(m1 < m2)
	{
		while(m1 < m2)
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
				break;
			}
		}
	}
	A[m1] = t;
	fast(A, n1, m1 - 1);
	fast(A, m1 + 1, n2);
}

void output(int A[], int n)
{
	for (int i = 0; i < n; i++)
		cout << A[i] << " ";
	cout << endl;
}

int main(void)
{
	int A[] = {4,23,23,6,2,8,2,-5};
	fast(A, 0, 7);
	output(A, 8);
	return 0;
}
