#include <iostream>
#include <iomanip>
using namespace std;

/* run this program using the console pauser or add your own getch, system("pause") or input loop */

int main(int argc, char *argv[]) {
	int r;
	double PI = 3.14159265358979323;
	cin >> r;
	cout << fixed << setprecision(7) << r*r*PI;
	return 0;
}
