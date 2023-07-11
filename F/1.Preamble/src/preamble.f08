!> @file preamble.f08
!> @brief This example is to check that the compilation process works.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/preamble`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)
 
PROGRAM main
	USE omp_lib

	IMPLICIT NONE

	WRITE(*, '(A,I0,A)') 'According to OpenMP: there are ', omp_get_num_devices(), ' GPUs.'
END PROGRAM main