#include <iostream>
using namespace std;

int main(void)
{
   int f[2] = {1,1};
   bool b = true;
   double ans = 0;
   for(int i = 0; i < 15; i++)
   {
       if(b)
       {
           f[0] += f[1];
           ans += double(f[0])/f[1];
           b = false;
       }
       else
       {
           f[1] += f[0];
           ans += double(f[1])/f[0];
           b = true;
       }
    }
   cout << ans << endl;
    return 0;
}
