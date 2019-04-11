#include <iostream>
using namespace std;

//ц╟ещ 
int main(int argc, char *argv[]) {
	int n;
	cin >> n;
	int *a = new int[n];
	bool b;
	for (int i = 0; i < n; i++)
		cin >> a[i];
	while (true)
	{
		b = true;
		for (int i = 1; i < n; i++)
		{
			if (a[i-1] < a[i])
			{
				b = false;
				a[i-1] ^= a[i];a[i] ^= a[i-1]; a[i-1] ^= a[i]; 
			}
		} 
		n--;
		cout << a[n] << ' ';
		if (b)
		{
			for (; n > 0;)
			{
				n--;
				cout << a[n] << ' ';
			}
			break;
		}
	}
	delete[] a;
	return 0;
}
