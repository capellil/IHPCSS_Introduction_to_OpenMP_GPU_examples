/**
 * @file helloworld.c
 * @brief This example is to illustrate how to offlaod execution to a target
 * device.
 * @details You will find two folders in this example, and will in all examples
 * provided in this session:
 * - src: contains the source code.
 * - bin: contains the binary produced.
 *
 * The makefile provided already sets everything up for you:
 * - To compile: `make`.
 * - To execute: `./bin/helloworld`.
 *
 * If you have any questions, do not hesitate.
 * @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)
 **/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
 
int main(int argc, char* argv[])
{
	int a[10];
	int b[10];
	int c[10];

	for(int i = 0; i < 10; i++)
	{
		b[i] = i + 123;
		c[i] = i * 10;
	}

	#pragma omp target
	{
		// Offload that loop to the GPU
		for(int i = 0; i < 10; i++)
		{
			a[i] = b[i] + c[i];
		}
	}

	for(int i = 0; i < 10; i++)
	{
		printf("a[%d] = %d\n", i, a[i]);
	}

	return EXIT_SUCCESS;
}