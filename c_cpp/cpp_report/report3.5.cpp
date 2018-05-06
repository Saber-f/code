//教材P196三大题第三小题
#include <iostream>
using namespace std;

class Count
{
    public:
    Count() {count++;};
    static int HM() {return count;}
    ~Count() {count--;}

    private:
    static int count;
};

int Count::count = 100;

int main(void)
{
    Count c1, c2, c3, c4;
    cout << Count::HM() << endl;
    return 0;
}