!> @file multilevelparallelism.f08
!> @brief This example is to illustrate how to parallelise nested for loops.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/multilevelparallelism`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)

!> @brief This exercise asks to parallelise nested loops.
PROGRAM main
	USE OMP_LIB

	IMPLICIT NONE
	
    INTEGER :: i
    INTEGER :: j
	INTEGER, DIMENSION(0:9,0:19) :: a
	INTEGER :: total = 0

	! Parallelise this over teams
    !$OMP TARGET ENTER DATA MAP(ALLOC:a)
    !$OMP TARGET TEAMS DISTRIBUTE REDUCTION(+:total)
	DO i = 0, 9
		! Parallelise this over threads in each team
        !$OMP PARALLEL DO DEFAULT(NONE) SHARED(a) FIRSTPRIVATE(i) REDUCTION(+:total)
		DO j = 0, 19
			a(i,j) = i * j
			total = total + a(i,j)
		END DO
	END DO
    !$OMP TARGET EXIT DATA MAP(DELETE:a)
	
	WRITE(*, '(A,I0)') 'The total is ', total
END PROGRAM main
