#include<iostream>
#include<stdio.h>
using namespace std;

int main(void)
{
	int n = 0;
	char s[100] = {'\0'};
	s[0] = getchar();
	if(s[0] >= 'a' && s[0] <= 'z')
			s[0] += 'A' - 'a';	
	for(int i = 1; i < 100; i++)
	{
		s[i] = getchar();
		if(s[i] == '\n')
        {
          	s[i] == '\0';
          	break;
        }
        n++;
		if((s[i-1] < 'a' || s[i-1] > 'z') && (s[i-1] < 'A' || s[i-1] > 'Z') && s[i] >= 'a' && s[i] <= 'z')
			s[i] += 'A' - 'a';	
	}
	for(int i = 0; i <= n ; i++)
		cout << s[i];
	return 0;
}
