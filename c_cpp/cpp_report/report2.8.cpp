//P160第四大题第八小题
#include <iostream>
#include <stdlib.h>
using namespace std;

void int2str(int n,char *s)
{
	if (n == 0 && *s != 0)
	{
		int m = *s;
		*s = s[m];
		for (int i(1); i < (m + 1) / 2; i++)
		{
			s[i] ^= s[m-i];
			s[m-i] ^= s[i];
			s[i] ^= s[m - i];
		}
		s[m] = '\0';
		return;
	}
	*s += 1;
	s = (char *)realloc(s, sizeof(char)*((*s) + 1));
	s[*s] = n % 10 + '0';
	n /= 10;
	int2str(n, s);
}

int main(void)
{
	char *s = (char *)malloc(sizeof(char));
	int n;
	*s = 0;
	cout << "n::";
	cin >> n;
	int2str(n, s);
	cout << "s::" << s << endl;
	free(s);
	return 0;
}
