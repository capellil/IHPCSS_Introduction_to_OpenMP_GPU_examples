!> @file asynchronous.c
!> @brief This example is to illustrate how to leverage asynchronous execution.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/asynchronous`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)

!> @brief In this exercise, you must issue each of the four assignments in a
!> different target construct, and take care of underlying dependencies. You
!> must also execute your offloading in an asynchronous way.
PROGRAM main
	USE OMP_LIB

	IMPLICIT NONE
	
	INTEGER :: a
	INTEGER :: b
	INTEGER :: c
	INTEGER :: d

	! Offload this assignment
	a = 123
	! Offload this assignment
	b = 123
	! Offload this assignment
	c = a + b
	! Offload this assignment
	d = a + c

	WRITE(*, '(A,I0)') 'a = ', a
	WRITE(*, '(A,I0)') 'b = ', b
	WRITE(*, '(A,I0)') 'c = ', c
	WRITE(*, '(A,I0)') 'd = ', d
END PROGRAM main