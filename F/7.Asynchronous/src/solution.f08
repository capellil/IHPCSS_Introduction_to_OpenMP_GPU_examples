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

	!$OMP TARGET DATA MAP(FROM:a,b,c,d)
		! Offload this assignment
		!$OMP TARGET MAP(FROM:a) NOWAIT DEPEND(OUT:a)
			a = 123
		!$OMP END TARGET
		! Offload this assignment
		!$OMP TARGET MAP(FROM:b) NOWAIT DEPEND(OUT:b)
			b = 123
		!$OMP END TARGET
		! Offload this assignment
		!$OMP TARGET MAP(TO:a,b) MAP(FROM:c) NOWAIT DEPEND(IN:a,b) DEPEND(OUT:c)
			c = a + b
		!$OMP END TARGET
		! Offload this assignment
		!$OMP TARGET MAP(TO:a,c) MAP(FROM:d) NOWAIT DEPEND(IN:a,c) DEPEND(OUT:d)
			d = a + c
		!$OMP END TARGET
	!$OMP END TARGET DATA

	WRITE(*, '(A,I0)') 'a = ', a
	WRITE(*, '(A,I0)') 'b = ', b
	WRITE(*, '(A,I0)') 'c = ', c
	WRITE(*, '(A,I0)') 'd = ', d
END PROGRAM main