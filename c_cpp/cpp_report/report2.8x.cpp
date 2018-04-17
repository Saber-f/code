//P160第四大题第八小题
#include <iostream>
#include <stdlib.h>
using namespace std;

void bec(char *s, int i)
{
    if(i == *s)
    {
        s[i] = '\0';
        return;
    }
    char c = s[*s-i];
    bec(s, i+1);
    s[i] = c;
}

void int2str(int n,char *s)
{
	if (n == 0 && *s != 1)
	{
        bec(s, 0);
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
