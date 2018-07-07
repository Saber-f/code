#include <stdio.h>
#include <math.h>

int main(void)
{	
	float x = -4,y;
	y = sqrt(x);
	printf("%f\n",y);
	if(x < 0) y = sqrt(-x);
	printf("%f\n",y);
	return 0;
}
