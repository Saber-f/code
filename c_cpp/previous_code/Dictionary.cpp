#include <stdio.h>
#include <stdlib.h>

//   test = {'df':'sfssd','asfe':{'asdf':'asdfae'},'kh':'dg','sdfg',:{'dfa':'fwe','erg':{'few':'fwef','wtw':'gwerg'}}}
// dir = {'a':'1','b':'2','c':'3'}

#pragma region MyRegion
///结构体定义

//储存字典的树节点声明
typedef struct node_tree NODE_TREE;

//储存变量名的栈节点定义
typedef struct val_name
{
	char *name;
	NODE_TREE *NT;
	struct val_name *next;
}VAL_NAME;

//储存函数名的栈节点定义
typedef struct func_name
{
	const char *data;
	int num;//内建函数的编号
	struct func_name *next;
}FUNC_NAME;

//储存字典的树节点定义
typedef union {
	NODE_TREE *tree;
	char *data;
}DATA;
typedef struct node_tree
{
	int flag;//0data为数据，1data为树
	char *name;
	DATA data;
	struct node_tree *left, *right;
}NODE_TREE;


///普通函数声明
char eat_blank();//吃点键盘缓冲区中的空格返回第一个非空格字符
char read_name(char *&name);//读取第函数或变量名并返回名后的第一个非空格变量，变量名错误则返回0
void func_init(FUNC_NAME *&func_list);//内建函数初始化
void func_push(FUNC_NAME *&func_list, const char *name);//将名为name的函数加入到内建函数列表func_list
void val_push(VAL_NAME *&val_list, char *name, NODE_TREE *NT);//将名为name的字典变量加入到字典列表val_list
NODE_TREE *input_dict();//键盘缓冲区的字典表达式输入data_list
void input_string(char *&s);//输入字符串'\''结束
int func_read(FUNC_NAME *func_list, char *s);//遍历函数列表返回对应内建函数编号，为再到则返回-1
NODE_TREE *val_search(VAL_NAME *val_list, char *name);//遍历变量列表，返回字典平衡树头节点，无则返回NULL
char *direct_read();//从键盘缓冲区读取字典索引

///平衡树相关函数声明
void sowp(NODE_TREE *p1, NODE_TREE *p2);//交换p1,p2的成员数据
void LL(NODE_TREE *&p);//LL型旋转
void RR(NODE_TREE *&p);//RR型旋转
void LR(NODE_TREE *&p);//LR型旋转
void RL(NODE_TREE *&p);//RL型旋转
int compare(char *name1, char *name2);//数据索引的大小比较(name1 <= name2返回1)
int push(NODE_TREE *&p, int flage, char *name, DATA data);//字典的索引和对应的内容入栈
void adjust(NODE_TREE *&p);//将树p调整为平衡树
int get_info(NODE_TREE *p);//左子树的深度减右子树的深度
int deep(NODE_TREE *p);//获取树的深度
void tree_destory(NODE_TREE *NT);//销毁释放树NT
NODE_TREE *search(NODE_TREE *NT, char *name);//浅层搜索，只搜索当前层
void tree_print(NODE_TREE *p, int flage);//中序遍历打印出结果

///内建函数声明
void i_exit(VAL_NAME *val_list);//退出函数并释放动态分配的空间
void i_del(VAL_NAME *&val_list, char *name);//从变量列表中删除名为name的变量
void i_print(NODE_TREE *NT,char c);//打印变量的值
void i_clear(VAL_NAME *&val_list);//清除所有变量
void i_help();//展示help
void i_cls();//清屏函函数
void i_list_val(VAL_NAME *val_list);//显示所有变量名称

#pragma endregion 定义结构体声明函数

int main(void)
{
	char c = 1, *name;//c为临时字符变量，那么为临时字符数组变量
	VAL_NAME *val_list = NULL;//变量名列表
	FUNC_NAME *func_list = NULL;//内建函数名列表
	NODE_TREE *data_tree = NULL;//字典树指针
	func_init(func_list);
	while (true)
	{
		read_name(name);//读取变量或函数名

		switch (func_read(func_list, name))//如果name是内建函数
		{
		case -1://不在内建函数列表
			c = '\0';
			break;
		case 0://退出函数
			i_exit(val_list);
			break;

		case 1://删除变量函数
			read_name(name);
			i_del(val_list, name);
			break;

		case 2://打印函数
			c = read_name(name);
			data_tree = val_search(val_list, name);
			i_print(data_tree,c);
			break;

		case 3://清除所有变量
			i_clear(val_list);
			break;

		case 4://帮助函数
			i_help();
			break;
			
		case 5://清屏
			i_cls();
			break;

		case 6://显示所有变量名
			i_list_val(val_list);
		}
	
		if (c == '\0')
			c = eat_blank();
		if (c == '=')//赋值语句判断
		{
			data_tree = input_dict();
			if(data_tree != NULL)//字典定义成功
				val_push(val_list, name, data_tree);//name如果已存在将会被覆盖
			eat_blank();//吃掉回车
			c = 1;
		}
		fflush(stdin);
	}
	return 0;
}

#pragma region MyRegion
///普通函数定义区
//吃点键盘缓冲区中的空格返回第一个非空格字符
char eat_blank()
{
	char c;
	c = getchar();
	while (c == ' ') c = getchar();
	return c;
}

//读取第函数或变量名并返回名后的第一个非空格变量，变量名错误则返回0
char read_name(char *&name)
{
	int n = 0;//字符数组name的角标
	char c;
	c = eat_blank();
	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_')//判断首字符是否合法
	{
		name = (char *)malloc(sizeof(char)*(n + 1));
		name[n++] = c;
		while (1) {
			c = getchar();
			if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c == '_' || (c >= '0' && c <= '9'))//判断是否为名称字符
			{
				name = (char *)realloc(name,sizeof(char)*(n + 1));
				name[n++] = c;
			}
			else
			{
				name = (char *)realloc(name,sizeof(char)*(n + 1));
				name[n] = '\0';
				return c;
			}
		}
	}
	else
	{
		printf("不能以字符%c作为名称的开头\n", c);
		return '\0';
	}
}

//内建函数初始化
void func_init(FUNC_NAME *&func_list)
{
	const char *name;//储存函数名的临时变量
	func_list = NULL;

	//exit函数入栈-----------------0
	name = (char *)malloc(sizeof(char) * 7);
	name = "exit";
	func_push(func_list, name);

	//del_val函数入栈--------------1
	name = (char *)malloc(sizeof(char) * 4);
	name = "del";
	func_push(func_list, name);

	//print函数入栈----------------2
	name = (char *)malloc(sizeof(char) * 6);
	name = "print";
	func_push(func_list, name);

	//clear清除所有变量-------------3
	name = (char *)malloc(sizeof(char) * 6);
	name = "clear";
	func_push(func_list, name);

	//help现实内建函数简介-----------4
	name = (char *)malloc(sizeof(char) * 5);
	name = "help";
	func_push(func_list, name);

	//cls清屏函数------------------5
	name = (char *)malloc(sizeof(char) * 4);
	name = "cls";
	func_push(func_list, name);

	//list_val显示变量列表----------6                           
	name = (char *)malloc(sizeof(char) * 6);
	name = "list_val";
	func_push(func_list, name);
}

//将名为name的函数加入到内建函数列表func_list
void func_push(FUNC_NAME *&func_list, const char *name)
{
	static int num = 0;
	FUNC_NAME *p;//临时结构体指针变量
	if (!func_list)
	{
		func_list = (FUNC_NAME *)malloc(sizeof(FUNC_NAME));
		func_list->data = name;
		func_list->num = num++;
		func_list->next = NULL;
		return;
	}
	p = (FUNC_NAME *)malloc(sizeof(FUNC_NAME));
	p->data = name;
	p->num = num++;
	p->next = func_list;
	func_list = p;
}

//将名为name的字典变量加入到字典列表val_list,并查重覆盖
void val_push(VAL_NAME *&val_list, char *name, NODE_TREE *NT)
{
	VAL_NAME *p;
	if (val_list == NULL)
	{
		val_list = (VAL_NAME *)malloc(sizeof(VAL_NAME));
		val_list->name = name;
		val_list->NT = NT;
		val_list->next = NULL;
		return;
	}
	
	if (compare(val_list->name, name) == 0)
	{
		tree_destory(val_list->NT);
		val_list->NT = NT;
		return;
	}

	p = val_list;
	while (p->next)
	{
		if (compare(p->next->name, name) == 0)
		{
			p->next->NT = NT;
			return;
		}
		p = p->next;
	}
	
	p->next = (VAL_NAME *)malloc(sizeof(VAL_NAME));
	p = p->next;
	p->name = name;
	p->NT = NT;
	p->next = NULL;
}

//键盘缓冲区的字典表达式输入data_list
NODE_TREE *input_dict()
{
	int flage = 0;//表示状态的变量
	char c;//临时字符变量
	char *s1 = NULL,*s2 = NULL;//储存字符串的字符指针
	VAL_NAME *VN = NULL,*vp;//vp为临时结构体指针变量
	DATA d;//d为临时数据变量

	while (true)
	{
		c = eat_blank();
		switch (c)
		{
		case ',':
			break;
		case '\'':
			if (flage == 0)
			{
				input_string(s1);
			}
			else
			{
				input_string(s2);
				d.data = s2;
				//按顺序树规则插入
				if (push(VN->NT, 0, s1, d) == -1)//如果字典索引重复
				{
					printf("字典索引%s重复，该字典定义是败\n",s1);
					while (VN)
					{
						vp = VN;
						free(VN->name);
						tree_destory(VN->NT);
						VN = VN->next;
						free(vp);
					}
					return NULL;;
				}
				adjust(VN->NT);//调整为平衡树
				flage = 0;
			}
			break;
		case ':':
			flage = 1;
			break;
		case '{':
			vp = (VAL_NAME *)malloc(sizeof(VAL_NAME));
			vp->NT = NULL;
			vp->next = VN;
			VN = vp;
			if (flage == 1)
			{
				VN->name = s1;
				flage = 0;
			}
			break;
		case '}':
			if (VN->next == NULL)//读入完毕
			{
				return VN->NT;
			}
			d.tree = VN->NT;
			if (push(VN->next->NT, 1, VN->name, d) == -1)//如果字典索引重复
			{
				printf("字典索引%s重复，该字典定义是败\n",s1);
				while (VN)
				{
					vp = VN;
					free(VN->name);
					tree_destory(VN->NT);
					VN = VN->next;
					free(vp);
				}
				return NULL;;
			}
			adjust(VN->next->NT);//调整为平衡树
			flage = 0;
			VN = VN->next;
			break;
		default:
			printf("字符%c非法\n",c);
			return NULL;
		}
	}
}

//输入字符串'\''结束
void input_string(char *&s)
{
	char c;
	s = (char *)malloc(sizeof(char));
	for (int i = 0;; i++)
	{
		c = getchar();
		s = (char *)realloc(s,sizeof(char)*(i + 1));
		if (c == '\'')
		{
			s[i] = '\0';
			break;
		}
		s[i] = c;
	}
}

//遍历函数列表返回对应内建函数编号，为再到则返回-1
int func_read(FUNC_NAME *func_list, char *s)
{
	while(func_list)
	{
		if (compare((char *)func_list->data, s) == 0)
			return func_list->num;
		func_list = func_list->next;
	}
	return -1;
}

//遍历变量列表，返回字典平衡树头节点，无则返回NULL
NODE_TREE *val_search(VAL_NAME *val_list, char *name)
{
	while (val_list)
	{
		if (compare(val_list->name, name) == 0)
		{
			return val_list->NT;
		}
		val_list = val_list->next;
	}
	return NULL;
}

//从键盘缓冲区读取字典索引
char *direct_read()
{
	char c, *name = NULL;
	c = eat_blank();
	if (c == '\n')
		return NULL;
	if (c != '\'')
	{
		printf("direct_read 错误！ \n");
		exit(-1);
	}
	name = (char *)malloc(sizeof(char));
	for (int i = 0;; i++)
	{
		name = (char *)realloc(name, sizeof(char)*(i + 1));
		name[i] = getchar();
		if (name[i] == '\'')
		{
			name[i] = '\0';
			break;
		}
	}
	c = getchar();
	if (c != ']')
	{
		printf("direct_read 错误！ \n");
		getchar();
		exit(-1);
	}
	return name;
}

#pragma endregion 普通函数的定义

#pragma region MyRegion
///平衡树相关函数定义
//交换p1,p2的成员数据
void sowp(NODE_TREE *p1, NODE_TREE *p2)
{
	int flage;
	char *p;
	DATA data;
	flage = p1->flag; p1->flag = p2->flag; p2->flag = flage;
	p = p1->name; p1->name = p2->name; p2->name = p;
	data = p1->data; p1->data = p2->data; p2->data = data;
}

//LL型旋转
void LL(NODE_TREE *&p)
{
	NODE_TREE *cp;
	sowp(p, p->left);
	cp = p->left;
	p->left = p->left->left;
	cp->left = cp->right;
	cp->right = p->right;
	p->right = cp;
}

//RR型旋转
void RR(NODE_TREE *&p)
{
	NODE_TREE *cp = p;
	sowp(p, p->right);
	cp = p->right;
	p->right = p->right->right;
	cp->right = cp->left;
	cp->left = p->left;
	p->left = cp;
}

//LR型旋转
void LR(NODE_TREE *&p)
{
	RR(p->left);
	LL(p);
}

//RL型旋转
void RL(NODE_TREE *&p)
{

	LL(p->right);
	RR(p);
}

//数据索引的大小比较(name1 < name2返回-1,= 0, > 1)
int compare(char *name1, char *name2)
{
	for (int i = 0;; i++)
	{
		if (name1[i] > name2[i])
			return 1;
		else if (name1[i] < name2[i])
			return -1;
		else if (name1[i] == '\0' && name2[i] == '\0')
			return 0;
	}
}

//字典的索引和对应的内容入栈
int push(NODE_TREE *&p, int flage, char *name, DATA data)
{
	if (!p)
	{
		p = (NODE_TREE *)malloc(sizeof(NODE_TREE));
		p->name = name;
		p->data = data;
		p->flag = flage;
		p->left = p->right = NULL;
		return 0;
	}
	else
	{
		switch (compare(name, p->name))
		{
		case -1:
			push(p->left, flage, name, data);
			return 0;
		case 1:
			push(p->right, flage, name, data);
			return 0;
		case 0:
			return -1;
		default:
			printf("c:546 error!\n");
			return -2;
		}
	}
}

//将树p调整为平衡树
void adjust(NODE_TREE *&p)
{
	int n1, n2, n3;
	if (!p)
		return;
	adjust(p->left);
	adjust(p->right);

	n1 = get_info(p);
	if (n1 == 2)
	{
		n2 = get_info(p->left);
		if (n2 == 1)
			LL(p);
		else if (n2 == -1)
			LR(p);
	}
	else if (n1 == -2)
	{
		n3 = get_info(p->right);
		if (n3 == -1)
			RR(p);
		else if (n3 == 1)
			RL(p);
	}
}

//左子树的深度减右子树的深度
int get_info(NODE_TREE *p)
{
	if (!p)
		return 0;
	return deep(p->left) - deep(p->right);
}

//获取树的深度
int deep(NODE_TREE *p)
{
	int d1, d2;
	if (!p)
		return 0;
	d1 = deep(p->left) + 1;
	d2 = deep(p->right) + 1;
	return d1 > d2 ? d1 : d2;
}

//销毁释放树NT
void tree_destory(NODE_TREE *NT)
{
	if (NT == NULL)
		return;
	if (NT->flag)
		tree_destory(NT->data.tree);

	tree_destory(NT->left);
	tree_destory(NT->right);
	free(NT);
}

//浅层搜索，只搜索当前层
NODE_TREE *search(NODE_TREE *NT, char *name)
{
	if (NT == NULL)
		return NULL;
	switch (compare(name, NT->name))
	{
	case -1:
		return search(NT->left, name);
		break;
	case 1:
		return  search(NT->right, name);
		break;
	case 0:
		return NT;
	default:
		return NULL;
	}
}

//中序遍历打印出结果
void tree_print(NODE_TREE *p, int flage)
{
	if (flage == 0)
	{
		printf("{");
	}
	if (p == NULL)
	{
		return;
	}

	tree_print(p->left, -1);
	if (p->flag == 0)
	{
		if ((flage == 1 || flage == 0) && p->right == NULL)
		{
			printf("\'%s\':\'%s\'},", p->name, p->data.data);
			return;
		}
		else
			printf("\'%s\':\'%s\',", p->name, p->data.data);
	}
	else
	{
		printf("\'%s\':", p->name);
		tree_print(p->data.tree, 0);
	}
	if (flage == 0 || flage == 1)
		tree_print(p->right, 1);
	else
		tree_print(p->right, -1);
}

#pragma endregion 平衡树相关函数的定义

#pragma region MyRegion
/// 内建函数定义区
//退出函数并释放动态分配的空间
void i_exit(VAL_NAME *val_list)
{
	VAL_NAME *vp;
	while (val_list != NULL)
	{
		vp = val_list;
		free(val_list->name);//释放指针指向的储存变量名的空间
		tree_destory(val_list->NT);
		val_list->name = NULL;
		val_list = val_list->next;
		free(vp);
	}
	exit(0);
}

//从变量列表中删除名为name的变量
void i_del(VAL_NAME *&val_list, char *name)
{
	if (val_list == NULL)
	{
		printf("变量列表中不含有变量!\n");
	}
	if (compare(val_list->name, name) == 0)
	{
		free(val_list->name);
		tree_destory(val_list->NT);
		val_list = val_list->next;
		return;
	}
	while (val_list->next)
	{
		if (compare(val_list->next->name, name) == 0)
		{
			free(val_list->next->name);
			tree_destory(val_list->next->NT);
			val_list->next = val_list->next->next;
			return;
		}
		val_list = val_list->next;
	}
	printf("变量%s不存在!\n", name);
}

//打印变量的值
void i_print(NODE_TREE *NT,char c)
{
	char *name;
	if(c == '\n')
	{
		tree_print(NT, 0);
		printf("\b \n");
		return;
	}
	while (true)
	{
		name = direct_read();
		if (name == NULL)
		{
			if (NT->flag == 1)
			{
				tree_print(NT, 0);
				printf("\b ");
			}
			else
				printf("'%s'", NT->data.data);
			printf(" \n");
			return;
		}
		NT = search(NT, name);
	}
}

//清除所有变量
void i_clear(VAL_NAME *&val_list)
{
	VAL_NAME *p;
	while (val_list)
	{
		p = val_list;
		free(val_list->name);
		tree_destory(val_list->NT);
		val_list = val_list->next;
		free(p);
	}
}

//展示help
void i_help()
{
	printf("\n内建函数说明::\n\n\
	exit------------退出程序\n\
	del---------删除变量\n\
	print-----------打印变量\n\
	clear--------清除所有变量\n\
	help---------内建函数简介\n\
	cls--------------清屏函数\n\
	list_val-----显示变量列表\n\n");
}

//清屏函函数
void i_cls()
{
	system("cls");
}

//显示所有变量名称
void i_list_val(VAL_NAME *val_list)
{
	if (val_list == NULL)
	{
		printf("\n未定义变量!\n\n");
		return;
	}
	printf("\n已定义的变量：\n\n");
	while (val_list)
	{
		printf("%s\n",val_list->name);
		val_list = val_list->next;
	}
	printf("\n");
}
#pragma endregion 内建函数的定义
