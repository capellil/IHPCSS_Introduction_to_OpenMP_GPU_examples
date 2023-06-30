#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
 
int main(int argc, char* argv[])
{
	int a = 1;
	int x = 10;
	int b;
	int result;
	#pragma omp target map(to:a,x) map(alloc:b) map(from:result)
	{
		b = 20;
		result = a * x + b;
	}
	printf("Result = %d.\n", result);

	return EXIT_SUCCESS;
}
