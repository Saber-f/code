//P159第三大题第十三小题
#include <iostream>
using namespace std;

template <class T, int n>

T sum(T *s1)
{
	T sum(0);
	for (int i(0); i < n; i++)
		sum += s1[i];
	return sum;
}

int main(void)
{
	int Ia[] = { 18, 21, 36, 10, 70, 40 };
	double Da[] = { 3.4, 7.8, 1.2, 9.4, 2.5, 4.1 };
	int Is = sum<int,6>(Ia);
	double Ds = sum<double, 6>(Da);
	cout << Is << ',' << Ds << endl;
	return 0;
}