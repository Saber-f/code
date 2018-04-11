#include <iostream>
using namespace std;

class point
{
protected:
	int x0, y0;

public:
	point(int i = 0, int j = 0)
	{
		x0 = i, y0 = j;
	}

	virtual void set() = 0;

	virtual void draw() = 0;
};

class line :public point
{
protected:
	int x1, y1;

public:
	line(int i = 0, int j = 0, int m = 0, int n = 0) :point(i, j)
	{
		x1 = m, y1 = n;
	}

	void set()
	{
		cout << "line::set() called." << endl;
	}

	void draw()
	{
		cout << "line::draw() called." << endl;
	}
};

class ellipse :public point
{
protected:
	int x1, y1;
public:
	ellipse(int i = 0, int j = 0, int p = 0, int q = 0) :point(i, j)
	{
		x1 = p, y1 = q;
	}

	void set()
	{
		cout << "ellipse::set() called." << endl;
	}

	void draw()
	{
		cout << "ellipse::draw() called." << endl;
	}
};

void drawobj(point *p)
{
	p->draw();
}

void setobj(point *p)
{
	p->set();
}

int main(void)
{
	line * lineobj = new line;
	ellipse *elliobj = new ellipse;
	drawobj(lineobj);
	drawobj(elliobj);
	cout << endl;
	setobj(lineobj);
	setobj(elliobj);
	cout << endl << "Redeaw the object .." << endl;
	drawobj(lineobj);
	drawobj(elliobj);
	return 0;
}
