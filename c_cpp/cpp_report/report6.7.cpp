//修改p301的类complex，删除对+、-、/的重载，添加对*的重载，使得c1*c2,c1*2,2*c1都成立（c1,c2是复数类对象）。
#include <iostream>
using namespace std;

class complex
{
    public:
        complex()
        {real = imag = 0;}
        complex(double r, double i)
        {real = r; imag = i;}
        void p() {cout << real << " + " << imag << "i " << endl;}
        friend complex operator *(const complex &c1,const complex &c2);
        friend complex operator *(const complex &c1,const double &c2);
        friend complex operator *(const double &c1,const complex &c2);
    private:
        double real, imag;
};
complex operator *(const complex &c1,const complex &c2)
{
    return complex(c1.real*c2.real-c1.imag*c2.imag,c1.real*c2.imag+c1.imag*c2.real);
}   

complex operator *(const complex &c1,const double &c2)
{
    return complex(c1.real*c2,c1.imag*c2);
}

complex operator *(const double &c1,const complex &c2)
{
    return complex(c1*c2.real,c1*c2.imag);
}

int main(void)
{
    complex c1(-1.5,2.5),c2(2.5,-3.5);
    (c1*c2).p();
    (c1*2).p();
    (2*c2).p();    
    return 0;
}