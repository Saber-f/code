#include <iostream>
#include <ctime>
using namespace std;

inline double inf(double x)
{
	return x * x * x;
}

double f(double x)
{
	return x * x * x;
}

int main(void)
{
	clock_t start,stop,t1,t2;
  t1 = t2 = 0;
	for(int i = 0;i < 1e7; i++)
	{
    start = clock();
    inf(i*3.54);
    stop = clock();
    t1 += start - stop;

    start = clock();
    f(i*3.54);
    stop = clock();
    t2 += start - stop;
  }

  cout << t1 << endl;
  cout << t2 << endl;

  return 0;
}
