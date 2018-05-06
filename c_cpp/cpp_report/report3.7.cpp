#include <iostream>
using namespace std;

class student {
public:
	student() { num = 0; score = 0; }
	student(int num, float score) { this->num = num; this->score = score; }
	void display();
	void set_val(int num = -1, float score = -1);
    friend void print(student &s);
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

void print(student &s)
{
	cout << "num" << s.num << endl;
	cout << "name" << s.score << endl;
}

int main(void)
{
	student stu1, stu2(160603, 95.3), stu3;
	stu1.set_val(160641, 96.6);
    stu3.set_val();    
	stu1.display();
	stu2.display();
    print(stu3);
	return 0;
}