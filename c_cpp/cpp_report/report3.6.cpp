//教材P196三大题第四小题
#include <iostream>
using namespace std;

class A
{
    public:
    A(double t, double r) {Total = t; Rate = r;}
    friend double Count(A &a)
    {
        a.Total += a.Rate * a.Total;
        return a.Total;
    }

    private:
    double Total, Rate;
};

int main(void)
{
    A a1(1000.0, 0.036), a2(768.0, 0.028);
    cout << Count(a1) << "," << Count(a2) << endl;
    return 0;
}