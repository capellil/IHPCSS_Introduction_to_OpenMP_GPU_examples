!> @file multigpu.f08
!> @brief This example is to illustrate how to use multiple GPUs.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/multigpu`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)

!> @brief This exercise asks to write certain functions illustrating 
PROGRAM main
	USE OMP_LIB

	IMPLICIT NONE

	INTEGER :: initial_device_num = 0
	INTEGER :: num_devices = 0
	INTEGER :: default_device_num = 0

	! Find the identifier of the host device
	WRITE(*, '(A,I0)') 'The host device is device ', initial_device_num
	! Find the number of devices
	WRITE(*, '(A,I0,A)') 'There are ', num_devices, ' target device(s).'
	! Find the identifier of the default device
	WRITE(*, '(A,I0)') 'The default device is device ', default_device_num
	! Offload to default target device
	WRITE(*, '(A)') 'Executed from on default target device.'
	! Offload to default target device 0
	WRITE(*, '(A)') 'Executed from on target device #0.'
	! Offload to default target device 1
	WRITE(*, '(A)') 'Executed from on target device #1.'
	! Change default device to device 1, and print the default device.
	default_device_num = 0;
	WRITE(*, '(A,I0)') 'The default device is device ', default_device_num
END PROGRAM main