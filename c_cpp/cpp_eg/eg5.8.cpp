#include <iostream>
using namespace std;

class N
{
    public:
        N(int a = 3, int b = 5, int c = 7);
        
        int Aout()
        {return A;}

        int Bout()
        {return B;}

        int Cout()
        {return C;}
        
    private:
        int A, B, C;
};

N::N(int a, int b, int c)
{
    A = a;
    B = b;
    C = c;
}

int main(void)
{
    N X,Y(9, 11),Z(13, 15, 17);
    cout << "X=" << X.Aout() << "," << X.Bout() << "," << X.Cout() << endl;
    cout << "Y=" << Y.Aout() << "," << Y.Bout() << "," << Y.Cout() << endl;
    cout << "Z=" << Z.Aout() << "," << Z.Bout() << "," << Z.Cout() << endl;
    return 0;
}