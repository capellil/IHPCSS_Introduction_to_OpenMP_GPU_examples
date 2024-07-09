/**
 * @file datamapping.c
 * @brief This example is to illustrate the different mappings of data.
 * @details You will find two folders in this example, and will in all examples
 * provided in this session:
 * - src: contains the source code.
 * - bin: contains the binary produced.
 *
 * The makefile provided already sets everything up for you:
 * - To compile: `make`.
 * - To execute: `./bin/datamapping`.
 *
 * If you have any questions, do not hesitate.
 * @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)
 **/
 
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
 
int main(int argc, char* argv[])
{
	int a = 1;
	int x = 10;
	int b = 10;
	int result = 0;
	// Offload this to the device
    #pragma omp target map(from:b,result) map(to:a,x)
    {
        b = 20;
        result = a * x + b;
    }
	// End of offload
	printf("%d * %d + %d = %d.\n", a, x, b, result);

	return EXIT_SUCCESS;
}
