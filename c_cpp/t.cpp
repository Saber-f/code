#include <iostream>
#include <string>
using namespace std;

int main(void)
{
	char s[][5] = {"abcd","efgh","ijkl","mnop"};
	cout << strcat(s[0],s[1]) << endl;
	cout << s[1] << endl;
	return 0;
}
