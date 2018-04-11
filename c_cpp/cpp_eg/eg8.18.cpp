//利用纯虚函数，计算一些图形的面积

#include <iostream>
using namespace std;

class Shape
{
public:
	virtual double Area() const = 0;
};

//三角形
class Traingle :public Shape
{
private:
	double H, W;

public:
	Traingle(double h, double w): H(h), W(w) {}
	double Area() const { return W * H / 2; }
};

//矩形
class Rectangle :public Shape
{
private:
	double H, W;

public:
	Rectangle(double h, double w) :H(h), W(w) {}
	double Area() const { return H * W; }
};

//圆形
class Circle :public Shape
{
private:
	double radius;

public:
	Circle(double r) : radius(r) {}
	double Area() const { return radius * radius * 3.141592653; }
};

//梯形
class Trapezoid : public Shape
{
private:
	double T, B, H;

public:
	Trapezoid(double top, double bottom, double hight) :T(top), B(bottom), H(hight) {}
	double Area() const { return (T + B) * H / 2; }
};

//正方形
class Square :public Shape
{
private:
	double S;

public:
	Square(double side) :S(side) {}
	double Area() const { return S * S; }
};

class Application
{
public:
	double Compute(Shape *s[], int n) const;
};

double Application::Compute(Shape *s[], int n) const
{
	double sum(0);
	for (int i = 0; i < n; i++)
		sum += s[i]->Area();;
	return sum;
}

class MyProgram :public Application
{
private:
	Shape * *s;

public:
	MyProgram();
	~MyProgram();
	double Run();
};

MyProgram::MyProgram()
{
	s = new Shape *[5];
	s[0] = new Traingle(3.0, 4.0);
	s[1] = new Rectangle(6.0, 8.0);
	s[2] = new Circle(6.5);
	s[3] = new Trapezoid(10.0, 8.0, 5.0);
	s[4] = new Square(6.7);
}

MyProgram::~MyProgram()
{
	for (int i = 0; i < 5; i++)
		delete s[i];
	delete[]s;
}

double MyProgram::Run()
{
	double sum = Compute(s, 5);
	return sum;
}
int main(void)
{
	cout << "Area's sum = " << MyProgram().Run() << endl;
	return 0;
}
