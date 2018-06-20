//教材p287三大题第三小题
#include <iostream>
using namespace std;

class L
{
    public:
        void InitL(int x, int y) {X = x; Y = y;}
        void Move(int x, int y) {X += x; Y += y;}
        int GetX() {return X;};
        int GetY() {return Y;};

    private:
        int X, Y;
};

class R:public L
{
    public:
        void InitR(int x, int y, int w, int h)
        {
            InitL(x,y);
            W = w;
            H = h;
        }
        int GetW() {return W;}
        int GetH() {return H;}

    private:
        int W, H;

};

class V:public R 
{
    public:
        void fun() {Move(3,2);}
};

int main(void)
{
    V v;
    v.InitR(10,20,30,40);
    v.fun();
    cout << "{" << v.GetX()<< "," << v.GetY() << "," <<
            v.GetW() << "," << v.GetH() << "}" << endl;
    return 0;
}