!> @file helloworld.f08
!> @brief This example is to illustrate how to offlaod execution to a target
!> device.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/helloworld`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)

PROGRAM main
	USE OMP_LIB 
	
	IMPLICIT NONE
	
	INTEGER, DIMENSION(0:9) :: a
	INTEGER, DIMENSION(0:9) :: b
	INTEGER, DIMENSION(0:9) :: c

	DO i = 0, 9
		b(i) = i + 123
		c(i) = i * 10
	END DO

	! Offload that loop to the GPU
	DO i = 0, 9
		a(i) = b(i) + c(i)
	END DO

	DO i = 0, 9
		WRITE(*, '(A,I0,A,I))') 'a(', i, ') = ', a(i)
	END DO
END PROGRAM main