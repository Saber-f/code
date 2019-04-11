#include<stdio.h>
#define L 30
//python词法分析程序


char isKeyworld(char c)
{
	static int s = 0;
	if (c == -1)
	{
		s = 0;
		return 0;
	}
	switch (s)
	{
	case 0:
		switch (c)
		{
		case 'a':
			s = 1;
			break;

		case 'b':
			s = 3;
			break;

		case 'c':
			s = 7;
			break;

		case 'd':
			s = 14;
			break;

		case 'e':
			s = 16;
			break;

		case 'i':
			s = 19;
			break;

		case 'n':
			s = 20;
			break;

		case 'o':
			s = 21;
			break;

		case 'p':
			s = 23;
			break;

		case 'r':
			s = 24;
			break;

		case 'w':
			s = 27;
			break;

		case '_':
			s = 32;
			break;

		default:
			return -1;
		}
		break;
	case 1:
		if (c == 'n')
			s = 2;
		else
			return -1;
		break;

	case 2:
		if (c == 'd')
			return 1;
		else
			return -1;
		break;

	case 3:
		if (c == 'r')
			s = 4;
		else
			return -1;
		break;

	case 4:
		if (c == 'e')
			s = 5;
		else
			return -1;
		break;

	case 5:
		if (c == 'a')
			s = 6;
		else
			return -1;
		break;

	case 6:
		if (c == 'k')
			return 1;
		else
			return -1;
		break;

	case 7:
		if (c == 'o')
			s = 8;
		else
			return -1;
		break;

	case 8:
		if (c == 'n')
			s = 9;
		else
			return -1;
		break;

	case 9:
		if (c == 't')
			s = 10;
		else
			return -1;
		break;

	case 10:
		if (c == 'i')
			s = 11;
		else
			return -1;
		break;

	case 11:
		if (c == 'n')
			s = 12;
		else
			return -1;
		break;

	case 12:
		if (c == 'u')
			s = 13;
		else
			return -1;
		break;

	case 13:
		if (c == 'e')
			return 1;
		else
			return -1;
		break;

	case 14:
		if (c == 'e')
			s = 15;
		else
			return -1;
		break;

	case 15:
		if (c == 'f')
			return 1;
		else
			return -1;
		break;

	case 16:
		if (c == 'l')
			s = 17;
		else
			return -1;
		break;

	case 17:
		if (c == 'i')
			s = 18;
		else if (c == 's')
			s = 19;
		else
			return -1;
		break;

	case 18:
		if (c == 'f')
			return 1;
		else
			return -1;
		break;

	case 19:
		if (c == 'e')
			return 1;
		else
			return -1;
		break;

	case 20:
		if (c == 'f')
			return 1;
		else
			return -1;
		break;

	case 21:
		if (c == 'o')
			s = 22;
		else
			return -1;
		break;

	case 22:
		if (c == 't')
			return 1;
		else
			return -1;
		break;

	case 23:
		if (c == 'r')
			return 1;
		else
			return -1;
		break;

	case 24:
		if (c == 'a')
			s = 25;
		else
			return -1;
		break;

	case 25:
		if (c == 's')
			s = 26;
		else
			return -1;
		break;

	case 26:
		if (c == 's')
			return 1;
		else
			return -1;
		break;

	case 27:
		if (c == 'e')
			s = 28;
		else
			return -1;
		break;

	case 28:
		if (c == 't')
			s = 29;
		else
			return -1;
		break;

	case 29:
		if (c == 'u')
			s = 30;
		else
			return -1;
		break;

	case 30:
		if (c == 'r')
			s = 31;
		else
			return -1;
		break;

	case 31:
		if (c == 'n')
			return 1;
		else
			return -1;
		break;

	case 32:
		if (c == '_')
			s = 33;
		else
			return -1;
		break;

	case 33:
		if (c == 'n')
			s = 34;
		else
			return -1;
		break;

	case 34:
		if (c == 'a')
			s = 35;
		else
			return -1;
		break;

	case 35:
		if (c == 'm')
			s = 36;
		else
			return -1;
		break;

	case 36:
		if (c == 'e')
			s = 37;
		else
			return -1;
		break;

	case 37:
		if (c == '_')
			s = 38;
		else
			return -1;
		break;

	case 38:
		if (c == '_')
			return 1;
		else
			return -1;
	}
	return 0;
}



int main(void)
{
	FILE *fp, *fp2;
	char ch;
	if ((fopen_s(&fp2, "out.txt", "w")))
		printf("打开文件2失败！\n");
	if ((fopen_s(&fp, "123.py", "r")))
		printf("打开文件失败！\n");
	else
	{
		int s = 0, f = 1, ls = 0, st = 0; //st  id/keyword判断(0待判断，-1不是，1是keyword)
		while (1)
		{
			if (f && (ch = fgetc(fp)) == EOF)
				break;
			else
				f = 1;
			switch (s)
			{
			case 0:
				switch (ch)
				{
				case '<':
					s = 1;
					break;
				case '=':
					s = 4;
					break;
				case '!':
					s = 7;
					break;
				case '>':
					s = 9;
					break;
				case '+':
					s = 23;
					break;
				case '-':
					s = 27;
					break;
				case '*':
					s = 33;
					break;
				case '/':
					s = 39;
					break;
				case '#':
					fputc(ch, fp2);
					s = 45;
					break;
				case '"':
					fputc(ch, fp2);
					s = 47;
					break;
				case '\'':
					fputc(ch, fp2);
					s = 49;
					break;
				default:
					if (ch == '_' || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z'))
					{
						st = isKeyworld(ch);
						fputc(ch, fp2);
						s = 12;
					}
					else if (ch >= '0' && ch <= '9')
					{
						fputc(ch, fp2);
						s = 14;
					}
					else if (ch != '\n' && ch != ' ' && ch != '\t')
					{
						fputc(ch, fp2);
						fputs("                              delim\n", fp2);
					}
				}
				break;
				
			case 1:
				switch (ch)
				{
				case '=':
					fputs("<=                             relop\n", fp2);
					s = 0;
					break;
				default:
					fputs("<                              relop\n", fp2);
					f = s = 0;
				}
				break;

			case 4:
				switch (ch)
				{
				case '=':
					fputs("==                             relop\n", fp2);
					s = 0;
					break;
				default:
					fputs("=                              op\n", fp2);
					f = s = 0;
				}
				break;

			case 7:
				switch (ch)
				{
				case '=':
					fputs("!=                             op\n", fp2);
					f = s = 0;
				}
				break;

			case 9:
				switch (ch)
				{
				case '=':
					fputs(">=                             op\n", fp2);
					s = 0;
					break;
				default:
					fputs(">                              op\n", fp2);
					f = s = 0;
				}
				break;
			
			case 12://id/keyworld
				if (ch == '_' || (ch >= 'a' && ch <= 'z') || (ch >= 'A' && ch <= 'Z') || (ch >= '0' && ch <= '9'))
				{
					if (st == 0)
						st = isKeyworld(ch);
					else if (st == 1)
						st = -1;
					fputc(ch, fp2);
					ls++;
				}
				else
				{
					for(int i = L - ls; i > 0; i--)
						fputc(' ', fp2);
					if (st == 1)
						fputs("keyworld\n", fp2);
					else
						fputs("id\n", fp2);

					isKeyworld(-1);
					st = ls = f = s = 0;
				}
				break;

			case 14://数字
				if (ch >= '0' && ch <= '9')
				{
					fputc(ch, fp2);
					ls++;
				}
				else if (ch == '.')
				{
					fputc(ch, fp2);
					ls++;
					s = 15;
				}
				else if (ch == 'E' || ch == 'e')
				{
					fputc(ch, fp2);
					ls++;
					s = 17;
				}
				else
				{
					for (int i = L - ls; i > 0; i--)
						fputc(' ', fp2);
					fputs("digit\n", fp2);
					ls = f = s = 0;
				}
				break;

			case 15://数字
				if (ch >= '0' && ch <= '9')
				{
					putc(ch, fp2);
					ls++;
					s = 16;
				}
				else
				{
					fputs("-----------error 1\n", fp2);
					ls = f = s = 0;
				}
				break;

			case 16:
				if (ch >= '0' && ch <= '9')
				{
					fputc(ch, fp2);
					ls++;
				}
				else if (ch == 'E' || ch == 'e')
				{
					fputc(ch, fp2);
					ls++;
					s = 17;
				}
				else
				{
					for (int i = L - ls; i > 0; i--)
						fputc(' ', fp2);
					fputs("digit\n", fp2);
					ls = f = s = 0;
				}
				break;

			case 17:
				if (ch == '+' || ch == '-')
				{
					fputc(ch, fp2);
					ls++;
					s = 18;
					break;
				}
				else if (ch >= '0' && ch <= '9')
				{
					fputc(ch, fp2);
					ls++;
					s = 19;
					break;
				}
				else
				{
					fputs("-----------error 1\n", fp2);
					ls = f = s = 0;
				}
				break;


			case 18:
				if (ch >= '0' && ch <= '9')
				{
					putc(ch, fp2);
					ls++;
					s = 19;
				}
				else
				{
					fputs("-----------error 1\n", fp2);
					ls = f = s = 0;
				}
				break;

			case 19:
				if (ch >= '0' && ch <= '9')
				{
					fputc(ch, fp2);
					ls++;
				}
				else
				{
					for (int i = L - ls; i > 0; i--)
						fputc(' ', fp2);
					fputs("digit\n", fp2);
					ls = f = s = 0;
				}
				break;

			case 23:
				switch (ch)
				{
				case '+':
					fputs("++                             relop\n", fp2);
					s = 0;
					break;
				case '=':
					fputs("+=                             relop\n", fp2);
					s = 0;
					break;
				default:
					fputs("+                              relop\n", fp2);
					f = s = 0;
				}
				break;

			case 27:
				switch (ch)
				{
				case '-':
					fputs("--                             relop\n", fp2);
					s = 0;
					break;
				case '=':
					fputs("-=                             relop\n", fp2);
					s = 0;
					break;
				default:
					fputs("-                              relop\n", fp2);
					f = s = 0;
				}
				break;

			case 33:
				switch (ch)
				{
				case '*':
					s = 35;
					break;
				case '=':
					fputs("*=                             relop\n", fp2);
					s = 0;
					break;
				default:
					fputs("*                              relop\n", fp2);
					f = s = 0;
				}
				break;

			case 35:
				if (ch == '=')
				{
					fputs("**=                            relop\n", fp2);
					s = 0;
				}
				else
				{
					fputs("**                             relop\n", fp2);
					f = s = 0;
				}
				break;

			case 39:
				switch (ch)
				{
				case '/':
					s = 41;
					break;
				case '=':
					fputs("/=                             relop\n", fp2);
					s = 0;
					break;
				default:
					fputs("/                             relop\n", fp2);
					f = s = 0;
				}
				break;

			case 41:
				if (ch == '=')
				{
					fputs("//=                            relop\n", fp2);
					s = 0;
				}
				else
				{
					fputs("//                             relop\n", fp2);
					f = s = 0;
				}
				break;

			case 45:
				if (ch != '\n')
				{
					fputc(ch, fp2);
					ls++;
				}
				else
				{
					for (int i = L - ls; i > 0; i--)
						fputc(' ', fp2);
					fputs(" annotation\n", fp2);
					ls = f = s = 0;
				}
				break;

			case 47:
				if (ch != '"')
				{
					fputc(ch, fp2);
					ls++;
				}
				else
				{
					fputc(ch, fp2);
					for (int i = L - ls - 1; i > 0; i--)
						fputc(' ', fp2);
					fputs("string\n", fp2);
					ls = s = 0;
				}
				break;

			case 49:
				if (ch != '\'')
				{
					fputc(ch, fp2);
					ls++;
				}
				else
				{
					fputc(ch, fp2);
					for (int i = L - ls; i > 0; i--)
						fputc(' ', fp2);
					fputs("string\n", fp2);
					ls = s = 0;
				}
				break;
			}
		}
	}
	if (fclose(fp))
		printf("文件关闭失败\n");
	if (fclose(fp2))
		printf("文件2关闭失败\n");
	return 0;
}