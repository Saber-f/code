#include <iostream>
using namespace std;

class student{
    public:
        student(){num = 0;score = 0;}
        student(int num, float score){this->num = num; this->score = score;}
        void display();
        void set_val(int num, float score);
    private:
        int num; //学号
        float score; //考分
};

void student::display()
{
    cout << "num" << num << endl;
    cout << "name" << score << endl;
}

void student::set_val(int num, float score)
{
    this->num = num;
    this->score = score;
}

int main(void)
{
    student stu1,stu2(160603,95.3);
    stu1.set_val(160641,96.6);
    stu1.display();
    stu2.display();
    return 0;
}