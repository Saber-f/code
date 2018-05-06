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