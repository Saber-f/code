//P160第四大题第八小题
#include <iostream>
using namespace std;

void int2str(int n,char *s)
{
	if (n == 0 && *s != 1)
	{
		int m = *s - 1;
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
	s = (char *)realloc(s, sizeof(char)*((*s) + 1));
	s[*s] = n % 10 + '0';
	n /= 10;
	*s += 1;
	int2str(n, s);
}

int main(void)
{
	char *s = (char *)malloc(sizeof(char));
	int n;
	*s = 1;
	cout << "n::";
	cin >> n;
	int2str(n, s);
	cout << "s::" << s;
	free(s);
	return 0;
}