#include <iostream>
using namespace std;

int main(void)
{
    char s[][5] = {"abcd", "efgh", "ijkl", "mnop"};
    cout << strcat(strcat(strcat(s[0],s[1]),s[2]),s[3]) << endl;
    return 0;
}
