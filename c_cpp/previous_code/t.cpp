#include<stdio.h>

typedef struct tree
{
	int data;
	struct tree *left,*right;
}TREE;


void visit(TREE *p)
{
	if(!p)
		return;
	printf("%d\n",p->data);
	visit(p->left);
	visit(p->right);
}


int main(void)
{
	TREE *T = NULL;
	visi(T);
	return 0;
}
