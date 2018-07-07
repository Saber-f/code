//快速幂模运算
#include <iostream>
#include <cstdlib>
#include <ctime>
#define ALL 300
using namespace std;


typedef struct big_num 
{
    int n[ALL];
    int used;
}BN;


int main(void)
{
    BN x,e,n;//计算x^e%n
    srand((unsigned)time(NULL));
    cout <<  rand() << endl;
    return 0;
}