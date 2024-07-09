/**
 * @file dataenvironment.c
 * @brief This example is to illustrate the use of data environments.
 * @details You will find two folders in this example, and will in all examples
 * provided in this session:
 * - src: contains the source code.
 * - bin: contains the binary produced.
 *
 * The makefile provided already sets everything up for you:
 * - To compile: `make`.
 * - To execute: `./bin/dataenvironment`.
 *
 * If you have any questions, do not hesitate.
 * @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)
 **/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

/**
 * @brief Allocates, on both CPU and GPU, an array of \p length integers.
 * @param length The number of integers to allocate.
 * @return A pointer on the array allocated on the CPU.
 */
int* mirror_malloc(size_t length)
{
	int* p = (int*)malloc(sizeof(int) * length);
	if(p == NULL)
	{
		printf("There has been a problem during the dynamic allocation of %zu bytes.\n", length);
		exit(-1);
	}
	// Allocate on the device
	#pragma omp target enter data map(alloc:p[0:2])
	return p;
}

/**
 * @brief Deallocates, both on CPU and GPU, an array previously dynamically
 * allocated in a mirrored manner.
 * @param p The pointer to the dynamically allocated array to deallocate.
 * @pre The pointer \p p must point to an array that was dynamically allocated
 * in a mirrored manner, using function mirror_malloc().
 */
void mirror_free(int* p)
{
	// Deallocate from the device
	#pragma omp target exit data map(delete:p)
	free(p);
}

/**
 * @brief This program increments an array values using two separate constructs.
 * The objective is to find alternatives ways to do it.
 * @details Without merging the two target construct, puts data on the device
 * through the mirror_* functions for the version A. For the version B, achieve
 * the same effect by encapsulating both target constructs in a data
 * environment.
 **/
int main(int argc, char* argv[])
{
	// Version A: using functions
	int* a = mirror_malloc(2);
	a[0] = 123;
	a[1] = 456;
	#pragma omp target update to(a[0:2])
	#pragma omp target map(tofrom:a[0:2])
	{
		a[0]++;
		a[1]++;
	}
	#pragma omp target map(tofrom:a[0:2])
	{
		a[0]++;
		a[1]++;
	}
	#pragma omp target update from(a[0:2])
	printf("a[0] = %d.\n", a[0]);
	printf("a[1] = %d.\n", a[1]);
	mirror_free(a);

	// Version B: encapsulating both targets in a data environment.
	int b[2];
	b[0] = 123;
	b[1] = 456;
	#pragma omp target data map(tofrom:b[0:2])
	{
		#pragma omp target map(tofrom:b[0:2])
		{
			b[0]++;
			b[1]++;
		}
		#pragma omp target map(tofrom:b[0:2])
		{
			b[0]++;
			b[1]++;
		}
	}
	printf("b[0] = %d.\n", b[0]);
	printf("b[1] = %d.\n", b[1]);

	return EXIT_SUCCESS;
}
