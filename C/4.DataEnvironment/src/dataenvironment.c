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
	#pragma omp target enter data map(alloc:p)
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
	#pragma omp target exit data map(delete:p)
	free(p);
}

int main(int argc, char* argv[])
{
	int result = 0;
	int* a = mirror_malloc(1);
	#pragma omp target
	{
		(*a)++;
	}
	#pragma omp target
	{
		(*a)++;
	}
	#pragma omp target from(a[0:1])
	printf("%d = %d.\n", a);
	mirror_free(a);

	return EXIT_SUCCESS;
}
