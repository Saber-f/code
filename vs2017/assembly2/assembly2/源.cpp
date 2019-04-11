#include <stdio.h>


void p3_3()
{
	_asm {
		mov ax,0x1000
		mov ds,ax
		mov ax,[0]
	}

}



int main(void)
{
	p3_3();
	return 0;
}