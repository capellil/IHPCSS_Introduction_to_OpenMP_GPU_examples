/**
 * @file multilevelparallelism.c
 * @brief This example is to illustrate how to parallelise nested for loops.
 * @details You will find two folders in this example, and will in all examples
 * provided in this session:
 * - src: contains the source code.
 * - bin: contains the binary produced.
 *
 * The makefile provided already sets everything up for you:
 * - To compile: `make`.
 * - To execute: `./bin/multilevelparallelism`.
 *
 * If you have any questions, do not hesitate.
 * @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)
 **/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

/**
 * @brief This exercise asks to parallelise nested loops.
 **/
int main(int argc, char* argv[])
{
	int a[10][20];
	int total = 0;

	// Parallelise this over teams
    #pragma omp target enter data map(alloc:a)
    #pragma omp target teams distribute reduction(+:total)
	for(int i = 0; i < 10; i++)
	{
		// Parallelise this over threads in each team
        #pragma omp parallel for reduction(+:total)
		for(int j = 0; j < 20; j++)
		{
			a[i][j] = i * j;
			total += a[i][j];
		}
	}
    #pragma omp target exit data map(delete:a)
	
	printf("The total is %d.\n", total);

	return EXIT_SUCCESS;
}
