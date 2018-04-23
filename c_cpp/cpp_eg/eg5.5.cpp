//fu zhi gou zao han shu
#include <iostream>
using namespace std;

class TPoint
{
public:
    TPoint(int x, int y)
    {X = x; Y = y;}

    TPoint(TPoint &p);

    ~TPoint()
    {cout << "Destructor Called." << endl;}

    int Xcoord()
    {return X;}

    int ycoord()
    {return Y;}

private:
    int X, Y;
};

TPoint::TPoint(TPoint &p)
{
    X = p.X;
    Y = p.Y;
    cout << "Copy_iniialization Constructor Called" << endl;
}

TPoint f(TPoint Q);

int main(void)
{
    TPoint M(20,35),P(0,0);
    TPoint N(M);
    P = f(N);
    cout << "P = " << P.Xcoord() << "," << P.ycoord() << endl;
    return 0;
}

TPoint f(TPoint Q)
{
    cout << "ok" << endl;
    int x,y;
    x = Q.Xcoord()+10;
    y = Q.ycoord()+20;
    TPoint R(x,y);
    return R;
}


