#include<iostream>
#include<stdlib.h>
#include<time.h>

#define m_NULL 0x7fffffff

using namespace std;

class Hash
{
public:
	typedef struct data
	{
		int n;
		bool flage;
	}DATA;

	typedef struct HashYable
	{
		DATA *data;
		int all;
		int used;
		bool flage;//冲突标志
	}HASH;
	
	HASH *H;

	Hash()
	{
		H = NULL;
	}

	~Hash()
	{
		if (H)
		{
			free(H->data);
			free(H);
		}
	}

	void Init(int n)
	{
		H = new HASH;
		H->data = new DATA[n];		
		H->all =n;
		H->used = 0;
		for (int i = 0; i < n; i++)
		{
			H->data[i].n = m_NULL;
			H->data[i].flage = false;
		}
	}

	void Insert(int n)
	{
		int adress;
		if (H->all == H->used)
		{
			cout << "All used !" << endl;
			return;
		}
	
		adress = n % H->all;



		while (H->data[adress].n != m_NULL)
		{
			if (H->data[adress].n == n)//去重
				return;
			H->data[adress].flage = true;
			adress = (adress + 1) % H->all;
		}

		H->data[adress].n = n;
		H->used++;
	}

	int search(int n)
	{
		int adress = n % H->all;

		while (H->data[adress].n != n)
		{
			if(H->data[adress].flage)
				adress = (adress + 1) % H->all;
			else
			{
				return -1;
			}
		}
		return adress;
	}

	void test()
	{
		int data,adress;
		char c = 0;
		Init(20);
		srand((unsigned)time(NULL));
		while (H->all != H->used)
		{
			Insert(rand() % (10 * H->all));
		}
		cout << "all test data is::" << endl;
		for (int i = 0; i < H->all; i++)
		{
			cout << H->data[i].n << " ";
		}
		cout << endl;
		
		cout << endl << "please input the data whitch you want to search('x' to over)" << endl;
		while (c != 'x')
		{
			cin >> data;
			c = getchar();
			adress = search(data);
			if (adress == -1)
				cout << "not there" << endl;
			else
			{
				cout << "Site::" << adress << endl;
			}
		}
	}
};



int main(void)
{
	Hash H;
	H.test();
	return 0;
}
