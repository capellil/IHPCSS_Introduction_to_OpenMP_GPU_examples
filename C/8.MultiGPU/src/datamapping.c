#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
 
int main(int argc, char* argv[])
{
	printf("The host device is device %d.\n", omp_get_initial_device());
	printf("There are %d target device(s).\n", omp_get_num_devices());
	printf("The default device is device #%d.\n", omp_get_default_device());
	#pragma omp target
	{
		printf("Executed from on default target device.\n");
	}
	#pragma omp target device(0)
	{
		printf("Executed from on target device #0.\n");
	}
	#pragma omp target device(1)
	{
		printf("Executed from on target device #1.\n");
	}
	printf("Changing default device to device 1.\n");
	omp_set_default_device(1);
	printf("The default device is device #%d.\n", omp_get_default_device());
	#pragma omp target
	{
		printf("Executed from on default target device.\n");
	}
	#pragma omp target device(0)
	{
		printf("Executed from on target device #0.\n");
	}
	#pragma omp target device(1)
	{
		printf("Executed from on target device #1.\n");
	}

	return EXIT_SUCCESS;
}
