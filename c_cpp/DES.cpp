#include <iostream>
//#include "data.h"
using namespace std;

class DES
{
public:
	void input();


private:
	int M[64], C[64], K[64];
	int model;
};

void DES::input()
{
	cout << "加密输入1，,解密输入0::";
	cin >> model;
	if (model == 1)
	{
		cout << "M::";
		cin >> M;
		cout << "K::";
		cin >> K;
	}
	else if (model == 0)
	{
		cout << "M::";
		cin >> C;
		cout << "K::";
		cin >> K;
	}
	else
		cout << "error 1" << endl;



}

int main(void)
{
	DES D;
	D.input();
	return 0;
}