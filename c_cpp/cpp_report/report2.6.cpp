//解释P158第三大题第十一小题的输出。将函数print(char)的声明及其定义删除再运行，解释结果
#include <iostream>
using namespace std;

//void print(int),print(char),print(char *);

int main(void)
{
    int u(1998);
    print('u');
    print(u);
    print("abcd");
    return 0;
}
/*
void print(char x)
{
    cout << x << endl;
}

void print(char *x)
{
    cout << x << endl;
}

void print(int x)
{
    cout << x << endl;
}*/