!> @file datamapping.f08
!> @brief This example is to illustrate the different mappings of data.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/datamapping`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)

PROGRAM main
	USE OMP_LIB 
	
	IMPLICIT NONE
	
	INTEGER :: a = 1
	INTEGER :: x = 10
	INTEGER :: b = 10
	INTEGER :: result = 0
	! Offload this to the device
	b = 20
	result = a * x + b
	! End of offload
	WRITE(*, '(I0,A,I0,A,I0,A,I0)') a, ' * ', x, ' + ', b, ' = ', result
END PROGRAM main