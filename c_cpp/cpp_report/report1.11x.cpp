#include <iostream>
using namespace std;

int main(void)
{
    int i, j, a[8][8];
    a[0][0] = 1;
    for(i = 1; i < 8; i++)
    {
        a[i][0] = 1;
        a[i][i] = 1;
        for(j = 1; j < i; j++)
            a[i][j] = a[i-1][j-1] + a[i-1][j];
    }
    for(i = 0; i < 8; i++)
    {
        for(j = 0; j <= i; j++)
            cout << " " <<a[i][j];
        cout << endl;
    }
    return 0;
}
