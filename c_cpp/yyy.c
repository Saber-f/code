#include <stdio.h>
#include <stdlib.h> //清屏system("cls"),暂停system("pause")需要
#include<math.h>    //乘方pow需要

// 1、编写一个程序，在终端输入一个字符，输出它的ASCII码。
void fun1()
{
	char c;
	printf("Please input a character\n");
	getchar();
	scanf("%c",&c);
	printf("The ASCII of %c is %d\n",c,c);
    system("pause");//暂停
}

//2、编写一个程序计算两个正整数的最大公约数和最小公倍数。
void fun2()
{
    int m, n, k, min, max, i;
    scanf("%d%d", &m, &n);
    if (n < m)
    {
        k = n;
        n = m;
        m = k;
    }
    for (i = m; i > 0; i--)
    {
        if ((m % i == 0) & (n % i == 0))
        {
            max = i;
            break;
        }
    }
    min = m * n / max;
    printf("%d和%d的最大公约数是%d\n", m, n, max);
    printf("%d和%d的最小公倍数是%d\n", m, n, min);
    system("pause");//暂停
}

//3、请编写一个递归算法，计算m^n。
 unsigned long myPow(int m,int n)
{
   unsigned long tmp;
   if(n==0) return 1;
   if(n==1)	return m;
   if(n%2==0)
   {
   	 tmp=myPow(m,n/2);
   	 return tmp*tmp;
   }
   if(n%2!=0)
   return m*myPow(m,n-1);
}

void fun3()
{
    int m,n;
	printf("Please input the bottom number\n");
	scanf("%d",&m);
	printf("Please input the exponet number\n");
	scanf("%d",&n);
	printf("The result of power(m,n) is %1d\n",myPow(m,n));
    system("pause");//暂停
}

//4、计算下列定积分的值。
float func1(float x)
{
	return 2*x+3;
} 

float ING1(float a,float b)
{
	return(b-a)/2*(func1(a)+func1(b));
}

float func2(float x)
{
	return pow(x,3)+2*x-1;
}

float ING2(float a,float b)
{
	return ((b-a)/6)*(func2(a)+4*func2((a+b)/2)+func2(b));
}

float func3(float x)
{
	return pow(x,4)+pow(x,3)+1;
}

float x(float a,float b,int k)
{
	return a+k*(b-a)/4;
}

float ING3(float a,float b)
{
	return ((b-a)/90)*(7*func3(x(a,b,0))+32*func3(x(a,b,1))+12*func3(x(a,b,2))+32*func3(x(a,b,3))+7*func3(x(a,b,4)));
}

void fun4()
{
	float a,b;
    printf("2x + 3\n");
	printf("Please input the low & high limtation and the accuracy\n");
	printf("Low limitation:");
	scanf("%f",&a);
	printf("High limitation:");
	scanf("%f",&b);
	printf("The result of integration is %f\n",ING1(a,b));
    system("pause");//暂停

    printf("x^3 + 2x - 1\n");
    printf("Please input the low & high limitation and the accuracy\n");
	printf("Low limitation:");
	scanf("%f",&a);
	printf("High limitation:");
	scanf("%f",&b);
	printf("The result of integration is %f\n",ING2(a,b));
    system("pause");//暂停

    printf("x^4 + x^3 + 1\n");
    printf("Please input the low & high limitation and the accuracy\n");
	printf("Low limitation:");
	scanf("%f",&a);
	printf("High limitation:");
	scanf("%f",&b);
	printf("The result of integration is %f\n",ING3(a,b));
    system("pause");//暂停
}

//5、从终端输入10个整数，输出其中最大的数和次大的数。要求输入的10个整数互不相等。
void fun5()
{
	int a,maxVal=-1000,secondVal=-1000,i;
	for(i=1;i<=10;i++)
	{
		scanf("%d",&a);
		if(a>maxVal)
		{
		    secondVal=maxVal;
		    maxVal=a;
	    }
	    else
    	{
		    if(a>secondVal)
	    	secondVal=a;
    	}
	}
	printf("The max value is   %d\n",maxVal);
	printf("The second value is %d\n",secondVal);
    system("pause");//暂停
}

//6、编写一个程序，用位运算实现求整数10 的相反数。
void fun6()
{
	int a;
	a=~10+1;
	printf("%d",a);
	getchar();
    system("pause");//暂停
}

// 菜单,通过菜单调用完成解决6个典型类型问题的功能
void menu()
{
    int num; //mun记录选择的功能
    while (1)
    {
        system("cls"); // 清屏
        printf("1、编写一个程序，在终端输入一个字符，输出它的ASCII码。\n");
        printf("2、编写一个程序计算两个正整数的最大公约数和最小公倍数。\n");
        printf("3、请编写一个递归算法，计算m^n。\n");
        printf("4、计算下列定积分的值。\n");
        printf("5、从终端输入10个整数，输出其中最大的数和次大的数。要求输入的10个整数互不相等。\n");
        printf("6、编写一个程序，用位运算实现求整数10 的相反数。\n");
        printf("其他数字结束程序。\n");
        printf("请输入数字选择功能::");

        scanf("%d", &num); //输入选择的能的数字编号

        if (num < 1 || num > 6) 
            break;

        switch (num) //通过选择语句调用相应函数
        {
        case 1:
            system("cls"); // 清屏
            fun1();
            break;
        case 2:
            system("cls"); // 清屏
            fun2();
            break;
        case 3:
            system("cls"); // 清屏
            fun3();
            break;
        case 4:
            system("cls"); // 清屏
            fun4();
            break;
        case 5:
            system("cls"); // 清屏
            fun5();
            break;
        case 6:
            system("cls"); // 清屏
            fun6();
            break;
        }
    }
}

int main(void)
{
    menu(); //进入菜单
    return 0;
}