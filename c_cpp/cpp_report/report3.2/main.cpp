#include <iostream>
#include "student.h"
using namespace std;

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