#include <iostream>
using namespace std;

class A
{
  public:
    A(int a){this->a = a;cout << "1" << endl;}
    A(A &p){a=p.a;cout << "2" << endl;}
    ~A(){cout << "3" << endl;}
  private:
      int a;
};

A f(A c)
{
  A a(2);
  a = c;
  return a;
}

int main(void)
{
  A b(0);
  b = f(b);
  cout << "4" << endl;
  return 0;
}
