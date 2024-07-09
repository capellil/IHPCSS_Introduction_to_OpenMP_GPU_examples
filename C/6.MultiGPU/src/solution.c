/**
 * @file multigpu.c
 * @brief This example is to illustrate how to use multiple GPUs.
 * @details You will find two folders in this example, and will in all examples
 * provided in this session:
 * - src: contains the source code.
 * - bin: contains the binary produced.
 *
 * The makefile provided already sets everything up for you:
 * - To compile: `make`.
 * - To execute: `./bin/multigpu`.
 *
 * If you have any questions, do not hesitate.
 * @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)
 **/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

/**
 * @brief This exercise asks to write certain functions illustrating 
 **/
int main(int argc, char* argv[])
{
	// Find the identifier of the host device
	int initial_device_num = omp_get_initial_device();
	printf("The host device is device %d.\n", initial_device_num);
	// Find the number of devices
	int num_devices = omp_get_num_devices();
	printf("There are %d target device(s).\n", num_devices);
	// Find the identifier of the default device
	int default_device_num = omp_get_default_device();
	printf("The default device is device #%d.\n", default_device_num);
	// Offload to default target device
    #pragma omp target
    {
	    printf("Executed from on default target device.\n");
    }
	// Offload to default target device 0
    #pragma omp target device(0)
    {
	    printf("Executed from on target device #0.\n");
    }
	// Offload to default target device 1
    #pragma omp target device(1)
    {
	    printf("Executed from on target device #1.\n");
    }
	// Change default device to device 1, and print the default device.
    omp_set_default_device(1);
    default_device_num = omp_get_default_device();
	printf("The default device is device #%d.\n", default_device_num);

	return EXIT_SUCCESS;
}
