#include <iostream>
using namespace std;

class TDate
{
    private:
    int years, mon, day;
    
    public:
    TDate() {years = 0;mon = 0; day = 0;}
    ~TDate() {cout << "Destructor called" << endl;}
    void SetDate(int years, int mon, int day)//设置日期
    {
        this->years = years;
        this->mon = mon;
        this->day = day;
    }

    void Print()//打印日期
    {
        cout << years << '.' << mon << '.' << day << endl;
    }

    bool IsleapYear()
    {
        if(years % 4 == 0 && years % 100 != 0)
        {
            return true;
        }
        return false;
    }
};

int main(void)
{
    TDate date1,date2;
    date1.SetDate(1996,5,4);
    date2.SetDate(1998,4,9);
    int leap = date1.IsleapYear();
    cout << leap << endl;
    date1.Print();
    date2.Print();
    return 0;
}