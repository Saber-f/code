#include <iostream>
using namespace std;

//补考安排ga算法
class GA_b
{
    public:
        int **get_data();//获取数据返回01矩阵

        void print_array2(int **A01);//打印01矩阵

    private:
        int  Number_Class;//考试堂数       
};

GA_b::int **get_data()
{
    int **A01 = NULL;
    fstream f;
    f.open("test_data",ios::in);
    if(!f)
        cout << "打开文件出错" << endl;
    else
    {
        char ch;
        while((ch = f.get()) != EOF)
            cout << ch;
    }
}

int main(void)
{
    GA_b B;
    B.get_data();
    return 0;
}
