using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;


namespace counter
{
    /// <summary>
    /// MainWindow.xaml 的交互逻辑
    /// </summary>
    

    public partial class MainWindow : Window
    {
        public struct myNode
        {
            public double num;
            public char sym;
        };

        private string num_s, equation_s;                   //屏幕显示内容
        private int num_state;                              //数字状态
        private List<double> num_l = new List<double>();    //运算数值表
        private List<char> sym_l = new List<char>();        //运算数值表

        private int n;                                      //算式符号，数值索引

        private myNode memory;                              //内存

        public void refresh_display(char c)         //刷新数字显示
        {
            /*状态转换表
              	    0	.	1-9	  b	    p	
                0		1	 2			0
                1	1		 1	0/1/2	3	正小数
                2	2	1	 2	 0/2	4	正整数
                3	3		 3	0/3/4	1	负小数
                4	4	3	 4	 0/4	2	负整数
             */
            switch (num_state)
            {
                case -10:
                    num_state = 0;
                    screen.Content = num_s = "0";
                    refresh_display(c);
                    break;
                case -5://sqrt
                    for (int i = equation_s.Length - 2; ; i--)
                    {
                        if (equation_s[i] == '√')
                        {
                            screen2.Content = equation_s = equation_s.Remove(i, equation_s.Length - i);
                            break;
                        }
                    }
                    if (num_s[0] == '-')
                    {
                        if (num_s.Contains("."))            //如果是负小数
                            num_state = 3;
                        else                                //如果是负整数
                            num_state = 4;
                    }
                    else
                    {
                        if (num_s.Contains("."))            //如果是正小数
                            num_state = 1;
                        else                                //如果时正整数
                            num_state = 2;
                    }
                    refresh_display(c);
                    break;
                case -4:
                    for (int i = equation_s.Length - 2; ; i--)
                    {
                        if (equation_s[i] == ' ')
                        {
                            screen2.Content = equation_s = equation_s.Remove(i+1, equation_s.Length - i - 1);
                            break;
                        }
                    }
                    if (num_s[0] == '-')
                    {
                        if (num_s.Contains("."))            //如果是负小数
                            num_state = 3;
                        else                                //如果是负整数
                            num_state = 4;
                    }
                    else
                    {
                        if (num_s.Contains("."))            //如果是正小数
                            num_state = 1;
                        else                                //如果时正整数
                            num_state = 2;
                    }
                    refresh_display(c);
                    break;

                case -3://1/x
                    for(int i = equation_s.Length-2; ;i--)
                    {
                        if(equation_s[i] == '1' && equation_s[i+1] == '/')
                        {
                            screen2.Content = equation_s = equation_s.Remove(i, equation_s.Length - i);
                            break;
                        }
                    }
                    if (num_s[0] == '-')
                    {
                        if (num_s.Contains("."))            //如果是负小数
                            num_state = 3;
                        else                                //如果是负整数
                            num_state = 4;
                    }
                    else
                    {
                        if (num_s.Contains("."))            //如果是正小数
                            num_state = 1;
                        else                                //如果时正整数
                            num_state = 2;
                    }
                    refresh_display(c);
                    break;
                case -2:
                    screen2.Content = equation_s = "";
                    sym_l.Clear();num_l.Clear();
                    if(num_s[0] == '-')
                    {
                        if (num_s.Contains("."))            //如果是负小数
                            num_state = 3;
                        else                                //如果是负整数
                            num_state = 4;
                    }
                    else
                    {
                        if (num_s.Contains("."))            //如果是正小数
                            num_state = 1;
                        else                                //如果时正整数
                            num_state = 2;
                    }
                    refresh_display(c);
                    break;
                case -1:
                    screen.Content = num_s = "0";
                    num_state = 0;
                    refresh_display(c);
                    break;
                case 0:
                    if(c == '.')                            //转正小数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        num_state = 1;
                    }else if(c >= '1' && c <= '9')          //转正整数
                    {
                        num_s += c;
                        num_s = num_s.Remove(0, 1);
                        screen.Content = num_s;
                        num_state = 2;
                    }
                    break;


                case 1:
                    if (c >= '0' && c <= '9')               //保持正小数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        //num_state = 1;
                    }
                    else if(c == 'p')                       //正小数转负小数
                    {
                        num_s = "-" + num_s;
                        screen.Content = num_s;
                        num_state = 3;
                    }
                    else if(c == 'b')                       //退格
                    {
                        if (num_s[num_s.Length - 1] == '.') //如果字符串末尾为小数点
                        {
                            num_s = num_s.Remove(num_s.Length - 1, 1);
                            if (num_s[0] == '0')            //转0
                                num_state = 0;
                            else                            //正小数转正整数
                                num_state = 2;
                        }
                        else                                //保持正小数
                        {
                            num_s = num_s.Remove(num_s.Length - 1, 1);
                            //num_state = 1;
                        }
                        screen.Content = num_s;
                    }
                    break;


                case 2:
                    if (c >= '0' && c <= '9')               //保持正整数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        //num_state = 2;
                    }
                    else if (c == 'p')                      //正整数转负整数
                    {
                        num_s = "-" + num_s;
                        screen.Content = num_s;
                        num_state = 4;
                    }
                    else if(c == '.')                       //正整数转正小数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        num_state = 1;
                    }
                    else if(c == 'b')                       //退格
                    {
                        num_s = num_s.Remove(num_s.Length - 1, 1);
                        if (num_s.Length == 0)              //转0
                        {
                            num_s += '0';
                            num_state = 0;
                        }                               
                        screen.Content = num_s;
                    }
                    break;

                case 3:
                    if (c >= '0' && c <= '9')               //保持负小数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        //num_state = 3;
                    }
                    else if (c == 'p')                      //负整数转正整数
                    {
                        num_s = num_s.Remove(0, 1);
                        screen.Content = num_s;
                        num_state = 1;
                    }
                    else if (c == 'b')                      //退格
                    {
                        if (num_s[num_s.Length - 1] == '.') //如果字符串末尾为小数点
                        {
                            num_s = num_s.Remove(num_s.Length - 1, 1);
                            if (num_s.Length == 1)              //转0
                            {
                                num_s = num_s.Remove(0, 1);
                                num_s += '0';
                                num_state = 0;
                            }
                            else                            //装负整数
                                num_state = 4;
                        }
                        else                                //保持负小数
                        {
                            num_s = num_s.Remove(num_s.Length - 1, 1);
                            //num_state = 3;
                        }
                        screen.Content = num_s;
                    }
                    break;


                case 4:
                    if (c >= '0' && c <= '9')               //保持负整数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        //num_state = 4;
                    }
                    else if (c == 'p')                      //负整数转正整数
                    {
                        num_s = num_s.Remove(0, 1);
                        screen.Content = num_s;
                        num_state = 2;
                    }
                    else if (c == '.')                      //转负小数
                    {
                        num_s += c;
                        screen.Content = num_s;
                        num_state = 3;
                    }
                    else if (c == 'b')                      //退格
                    {
                        num_s = num_s.Remove(num_s.Length - 1, 1);
                        if (num_s.Length == 1)              //转0
                        {
                            num_s = num_s.Remove(0, 1);
                            num_s += '0';
                            num_state = 0;
                        }
                        screen.Content = num_s;
                    }
                    break;

            }

            //数字超过12位
            if(num_s[0] == '-' || num_s[0] == '0')
            {
                if (num_s.Length > 13)
                {
                    screen.Content = num_s.Remove(12, num_s.Length - 13);
                    MessageBox.Show("输入数值大于12位！  ");
                }
            }
            else
            {
                if (num_s.Length > 12)
                {
                    screen.Content = num_s.Remove(12, num_s.Length - 12);
                    MessageBox.Show("输入数值大于12位！  ");
                }
            }
        }

        public myNode F()
        {
            myNode n1 = new myNode();
            if (n > 0)
            {
                n1.num = num_l[n - 1];n1.sym = '\0';
                if (n < num_l.Count)
                    n = -n;
                else
                    n = 0;
            }
            return n1;
        }

        public myNode Tp()
        {
            myNode n1 = new myNode(), n2 = new myNode();
            n1.sym = n2.sym = '#'; //表示伊普西隆
            if (n < 0)
            {
                if (sym_l[-n - 1] == '*')
                {
                    n = -n + 1;
                    n1 = F();
                    n1.sym = '*';
                    n2 = Tp();
                }
                else if (sym_l[-n - 1] == '/')
                {
                    n = -n + 1;
                    n1 = F();
                    n1.sym = '/';
                    n2 = Tp();
                }
            }
            if (n2.sym == '*')
                n1.num *= n2.num;
            else if (n2.sym == '/')
            {
                if(n2.num == 0)
                {
                    num_state = -10;
                    n2.num = 1;
                }
                n1.num /= n2.num;
            }
            return n1;
        }

        public myNode T()
        {
            myNode n1 = new myNode(), n2 = new myNode();
            n1 = F();
            n2 = Tp();
            if (n2.sym == '*')
                n1.num *= n2.num;
            else if (n2.sym == '/')
            {
                if (n2.num == 0)
                {
                    num_state = -10;
                    n2.num = 1;
                }
                n1.num /= n2.num;
            }
            return n1;
        }

        public myNode Ep()
        {
            myNode n1 = new myNode(), n2 = new myNode();
            n1.sym = n2.sym = '#';
            if (n < 0)
            {
                if (sym_l[-n - 1] == '+')
                {
                    n = -n + 1;
                    n1 = T();
                    n1.sym = '+';
                    n2 = Ep();
                }
                else if(sym_l[-n - 1] == '-')
                {
                    n = -n + 1;
                    n1 = T();
                    n1.sym = '-';
                    n2 = Ep();
                }
            }
            if (n2.sym == '+')
                n1.num += n2.num;
            else if (n2.sym == '-')
                n1.num -= n2.num;
            return n1;
        }

        public myNode E()
        {
            myNode n1 = new myNode(), n2 = new myNode();
            n1 = T();
            n2 = Ep();
            if (n2.sym == '+')
                n1.num += n2.num;
            else if (n2.sym == '-')
                n1.num -= n2.num;
            return n1;
        }

        public void refresh_display2(char c)        //刷新算式显示
        {
            /*文法描述
             * E->TE'
             * E'->+TE'|-TE'|e
             * T->FT'
             * T'->*FT'|/FT'|e
             * F->i
             * */
            if (c == '=' && sym_l.Count < 1)
                return;

            if (c == 'x' || c == 'p' || c == 'r')
            {
                switch (num_state)
                {
                    case -5://sqrt
                        for (int i = equation_s.Length - 2; ; i--)
                        {
                            if (equation_s[i] == '√')
                            {
                                screen2.Content = equation_s = equation_s.Remove(i, equation_s.Length - i);
                                break;
                            }
                        }
                        break;
                    case -4:// %
                        for (int i = equation_s.Length - 2; ; i--)
                        {
                            if (i== -1 || equation_s[i] == ' ')
                            {
                                screen2.Content = equation_s = equation_s.Remove(i + 1, equation_s.Length - i - 1);
                                break;
                            }
                        }
                        break;

                    case -3://1/x
                        for (int i = equation_s.Length - 2; ; i--)
                        {
                            if (equation_s[i] == '1' && equation_s[i + 1] == '/')
                            {
                                screen2.Content = equation_s = equation_s.Remove(i, equation_s.Length - i);
                                break;
                            }
                        }
                        break;
                }
            }
            if(c == 'x')
            {
                if (Convert.ToDouble(num_s) == 0) //开方数小于0
                {
                    MessageBox.Show("0没有倒数！");
                    return;
                }
                screen2.Content = equation_s +=  "1/" + num_s + ' ';
                num_s = (1 / Convert.ToDouble(num_s)).ToString();
                
                //保留12位（不算正负号）
                int t;
                if (num_s[0] == '-')
                    t = 13;
                else
                    t = 12;
                if (num_s.Length > t)
                {
                    num_s = num_s.Remove(t, num_s.Length - t);
                    if (num_s[num_s.Length - 1] == '.')
                    {
                        num_s = num_s.Remove(t - 1, 1);
                    }
                }

                screen.Content = num_s;
                num_state = -3;
                return;
            }else if(c == 'p')
            {
                screen2.Content = equation_s += num_s + '%' + ' ';
                //保留12位（不算正负号）
                int t;
                num_s = (Convert.ToDouble(num_s) / 100).ToString();
                if (num_s[0] == '-')
                    t = 13;
                else
                    t = 12;
                if (num_s.Length > t)
                {
                    num_s = num_s.Remove(t, num_s.Length - t);
                    if (num_s[num_s.Length - 1] == '.')
                    {
                        num_s = num_s.Remove(t - 1, 1);
                    }
                }
                screen.Content = num_s;
                num_state = -4;
                return;
            }
            else if (c == 'r')
            {
                if(Convert.ToDouble(num_s) < 0) //开方数小于0
                {
                    MessageBox.Show("开方不能数小于0！");
                    return;
                }
                screen2.Content = equation_s += '√' + num_s + ' ';
                //保留12位（不算正负号）
                num_s = (Math.Sqrt(Convert.ToDouble(num_s))).ToString();
                int t;
                if (num_s[0] == '-')
                    t = 13;
                else
                    t = 12;
                if (num_s.Length > t)
                {
                    num_s = num_s.Remove(t, num_s.Length - t);
                    if (num_s[num_s.Length - 1] == '.')
                    {
                        num_s = num_s.Remove(t - 1, 1);
                    }
                }
                screen.Content = num_s;
                num_state = -5;
                return;
            }

            if (c == '+' || c == '-' || c == '*' || c == '/' || c == '=')
            {
                if(num_state == -2)
                {
                    if (c == '=')
                    {
                        equation_s =  equation_s.Remove(equation_s.Length-2,2) + sym_l[sym_l.Count - 1] + "";
                    }
                    else
                    {
                        screen2.Content = equation_s = "";
                        num_l.Clear(); sym_l.Clear();
                    }
                }
                if (num_state <= -3)
                    screen2.Content = equation_s += c + " ";
                else
                {
                    if (num_state == -2 && c == '=')
                        screen2.Content = equation_s += num_l[num_l.Count - 1].ToString() + ' ' + c + ' ';
                    else
                        screen2.Content = equation_s += num_s + ' ' + c + ' ';
                }

                if (num_state == -2 && c == '=')
                    num_l.Add(num_l[num_l.Count - 1]);
                else
                    num_l.Add(Convert.ToDouble(num_s));

                if (c == '=')
                    sym_l.Add(sym_l[sym_l.Count - 1]);
                else
                    sym_l.Add(c);
            }

            if (num_l.Count > 1)
            {
                n = 1;
                myNode n1 = E();
                num_s = n1.num.ToString();
                if (num_state == -10)                    //除数为0
                {
                    restoration();
                    num_state = -10;
                    screen.Content = num_s = "除数不能为零0！  ";
                    return;
                }

                //数字超过12位
                if (n1.num >= 999999999.5 || n1.num <= -999999999.5)
                {
                    restoration();
                    num_state = -10;
                    screen.Content = num_s = "运算结果超界！  ";
                    return;
                }

                //保留12位（不算正负号）
                int t;
                if (num_s[0] == '-')
                    t = 13;
                else
                    t = 12;
                if (num_s.Length > t)
                {
                    num_s = num_s.Remove(t, num_s.Length - t);
                    if (num_s[num_s.Length - 1] == '.')
                    {
                        num_s = num_s.Remove(t-1, 1);
                    }
                }

                screen.Content = num_s;

            }
         
            if (c == '=')
                num_state = -2;
            else
                num_state = -1;
        }

        public void restoration()                   //复位(初始化数字串和算式串)
        {
            screen.Content = num_s = "0";           //初始化数字屏幕内容为空
            num_state = 0;
            screen2.Content = equation_s = "";      //初始化算式屏幕内容为空
            num_l.Clear();
            sym_l.Clear();
        }

        public MainWindow()
        {  
            InitializeComponent();
            restoration();
            memory = new myNode();
            memory.sym = 'N';                       //表示空
        }

        private void Button_Click_0(object sender, RoutedEventArgs e) //向屏幕字符串末尾添加0
        {
            refresh_display('0');
        }

        private void Button_Click_rp(object sender, RoutedEventArgs e) //追加小数点
        {
            refresh_display('.');
        }

        private void Button_Click_1(object sender, RoutedEventArgs e) //追加1
        {
            refresh_display('1');
        }

        private void Button_Click_2(object sender, RoutedEventArgs e) //追加2
        {
            refresh_display('2');
        }

        private void Button_Click_3(object sender, RoutedEventArgs e) //追加3
        {
            refresh_display('3');
        }

        private void Button_Click_4(object sender, RoutedEventArgs e) //追加4
        {
            refresh_display('4');
        }

        private void Button_Click_5(object sender, RoutedEventArgs e) //追加5
        {
            refresh_display('5');
        }

        private void Button_Click_6(object sender, RoutedEventArgs e) //追加6
        {
            refresh_display('6');
        }

        private void Button_Click_7(object sender, RoutedEventArgs e) //追加7
        {
            refresh_display('7');
        }

        private void Button_Click_8(object sender, RoutedEventArgs e) //追加8
        {
            refresh_display('8');
        }

        private void Button_Click_9(object sender, RoutedEventArgs e) //追加9
        {
            refresh_display('9');
        }

        private void Button_Click_bk(object sender, RoutedEventArgs e)
        {
            refresh_display('b');//bk
        }

        private void Button_Click_pm(object sender, RoutedEventArgs e)
        {
            refresh_display('p');//正负转换
        }

        private void Button_Click_ce(object sender, RoutedEventArgs e)
        {
            num_state = 0;
            screen.Content = num_s = "0";
        }

        private void Button_Click_c(object sender, RoutedEventArgs e)
        {
            restoration();
        }

        private void Button_Click_sub(object sender, RoutedEventArgs e)
        {
            refresh_display2('-');
        }

        private void Button_Click_mul(object sender, RoutedEventArgs e)
        {
            refresh_display2('*');
        }

        private void Button_Click_div(object sender, RoutedEventArgs e)
        {
            refresh_display2('/');
        }

        private void Button_Click_equ(object sender, RoutedEventArgs e)
        {
            refresh_display2('=');
        }

        private void Button_Click_rec(object sender, RoutedEventArgs e)
        {
            refresh_display2('x');
        }

        private void Button_Click_per(object sender, RoutedEventArgs e)
        {
            refresh_display2('p');
        }

        private void Button_Click_root(object sender, RoutedEventArgs e)
        {
            refresh_display2('r');
        }

        private void Button_Click_mc(object sender, RoutedEventArgs e)
        {
            memory.sym = 'N';
            screen3.Content = "";
        }

        private void Button_Click_mr(object sender, RoutedEventArgs e)
        {
            if (memory.sym == 'Y')
                screen.Content = num_s = memory.num.ToString();
        }

        private void Button_Click_ms(object sender, RoutedEventArgs e)
        {
            memory.sym = 'Y';
            memory.num = Convert.ToDouble(num_s);
            screen3.Content = memory.num.ToString();
        }

        private void Button_Click_madd(object sender, RoutedEventArgs e)
        {
            if (memory.sym == 'Y')
                memory.num += Convert.ToDouble(num_s);
            else if (memory.sym == 'N')
            {
                memory.num = Convert.ToDouble(num_s);
                memory.sym = 'Y';
            }
            screen3.Content = memory.num.ToString();
        }

        private void Button_Click_msub(object sender, RoutedEventArgs e)
        {
            if (memory.sym == 'Y')
                memory.num -= Convert.ToDouble(num_s);
            else if (memory.sym == 'N')
            {
                memory.num = -Convert.ToDouble(num_s);
                memory.sym = 'Y';
            }
            screen3.Content = memory.num.ToString();
        }

        private void Button_Click_add(object sender, RoutedEventArgs e)
        {
            refresh_display2('+');
        }

    }
}
