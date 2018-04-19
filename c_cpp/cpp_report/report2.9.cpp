#include <iostream>
#include <math.h>
using namespace std;

int get_d(int x1, int y1, int x2, int y2)
{
    return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
}

float get_d(float x1, float y1, float x2, float y2)
{
    return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
}

int main(void)
{
    int nx1,nx2,ny1,ny2;
    float fx1,fx2,fy1,fy2;
    cout << "x1 y1 x2 y2" << endl;
    cin >> nx1 >> ny1 >> nx2 >> ny2;
    cout << "d = " << get_d(nx1, ny1, nx2, ny2) << endl;
    cin >> fx1 >> fy1 >> fx2 >> fy2;
    cout << "d = " << get_d(fx1, fy1, fx2, fy2) << endl;
    return 0;
}
