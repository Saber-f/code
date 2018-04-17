//变步长辛普生求积分算法

#include <iostream>
#include <math.h>
using namespace std;

class F
{
public:
	virtual double operator()(double) const = 0;
};

class Integral
{
public:
	virtual double operator()(double a, double b, double eps) const = 0;
};

class Simpson :public Integral
{
private:
	const F &f;
public:
	Simpson(const F &ff) :f(ff) {}

	virtual double operator()(double a, double b, double eps) const;
};

double Simpson::operator()(double a, double b, double eps) const
{
	int done(0);
	int n;
	double h, Tn, T2n, In, I2n;
	n = 1;
	h = b - a;
	Tn = h * (f(a) + f(b)) / 2.0;
	In = Tn;
	while (!done)
	{
		double temp(0.0);
		for (int k = 0; k < n - 1; k++)
		{
			double x = a + (k + 0.5) * h;
			temp += f(x);
		}
		T2n = (Tn + h * temp) / 2.0;
		I2n = (4.0*T2n - Tn) / 3.0;
		if (fabs(I2n - In) < eps)
			done = 1;
		else
		{
			Tn = T2n;
			In = I2n;
			n *= 2;
			h /= 2;
		}
	}
	return I2n;
}

class Function :public F
{
public:
	virtual double operator()(double x) const
	{
		return log(1.0 + x) / (1.0 + x * x);
	}
};

int main(void)
{
	Function f;
	Simpson simp(f);
	cout << simp(0, 2, 1E-7) << endl;
	return 0;
}

