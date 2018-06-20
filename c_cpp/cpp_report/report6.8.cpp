#include <iostream>
#include <cstring>
using namespace std;

class A
{
    public:
        A(const char *p) 
        { 	
            len = strlen(p)+1;
            pchar = new char[len];
            strcpy(pchar,p);
 	    }
        A(const A &a)
        {
            len = a.len;
            pchar = new char[len];
            strcpy(pchar,a.pchar);
        }
        ~A() { delete pchar; pchar=0; }
        A& operator =(const char *p) {this->len = strlen(p)+1;delete this->pchar;this->pchar = new char[this->len];strcpy(this->pchar,p);return *this;}
        void p() {cout << pchar;}
        private:
            char *pchar;
            int len;
};

int main(void)
{
    A a1("hello\n");
    A a2=a1;
    a1.p();
    a2.p();
    a2 = "lalala";
    a2.p();
    return 0;
}