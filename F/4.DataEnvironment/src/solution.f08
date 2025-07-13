!> @file dataenvironment.f08
!> @brief This example is to illustrate the use of data environments.
!> @details You will find two folders in this example, and will in all examples
!> provided in this session:
!> - src: contains the source code.
!> - bin: contains the binary produced.
!>
!> The makefile provided already sets everything up for you:
!> - To compile: `make`.
!> - To execute: `./bin/dataenvironment`.
!>
!> If you have any questions, do not hesitate.
!> @author Ludovic Capelli (l.capelli@epcc.ed.ac.uk)

!> @brief This program increments an array values using two separate constructs.
!> The objective is to find alternatives ways to do it.
!> @details Without merging the two target construct, puts data on the device
!> through the mirror_* functions for the version A. For the version B, achieve
!> the same effect by encapsulating both target constructs in a data
!> environment.
PROGRAM main
	USE OMP_LIB 
	
	IMPLICIT NONE

	INTEGER, ALLOCATABLE :: a(:)
	INTEGER, DIMENSION(0:1) :: b

	! Version A: using functions
	CALL mirror_malloc(a, 2)
	a(0) = 123
	a(1) = 456
    !$OMP TARGET UPDATE TO(a(0:2))
	!$OMP TARGET MAP(TOFROM:a(0:2))
		a(0) = a(0) + 1
		a(1) = a(1) + 1
	!$OMP END TARGET
	!$OMP TARGET MAP(TOFROM:a(0:2))
		a(0) = a(0) + 1
		a(1) = a(1) + 1
	!$OMP END TARGET
    !$OMP TARGET UPDATE FROM(a(0:2))
	WRITE(*, '(A,I0)') 'a(0) = ', a(0)
	WRITE(*, '(A,I0)') 'a(1) = ', a(1)
	CALL mirror_free(a);

	! Version B: encapsulating both targets in a data environment.
	b(0) = 123
	b(1) = 456
    !$OMP TARGET DATA MAP(TOFROM:b(0:2))
        !$OMP TARGET MAP(TOFROM:b(0:2))
            b(0) = b(0) + 1
            b(1) = b(1) + 1
        !$OMP END TARGET
        !$OMP TARGET MAP(TOFROM:b(0:2))
            b(0) = b(0) + 1
            b(1) = b(1) + 1
        !$OMP END TARGET
    !$OMP END TARGET DATA
	WRITE(*, '(A,I0)') 'a(0) = ', b(0)
	WRITE(*, '(A,I0)') 'a(1) = ', b(1)

	CONTAINS

	!> @brief Allocates, on both CPU and GPU, an array of \p length integers.
	!> @param length The number of integers to allocate.
	!> @return A pointer on the array allocated on the CPU.
	SUBROUTINE mirror_malloc(a, length)
		IMPLICIT NONE

		INTEGER, ALLOCATABLE :: a(:)
		INTEGER :: length

		ALLOCATE(A(0:length-1))
		! Allocate on the device
        !$OMP TARGET ENTER DATA MAP(ALLOC:A(0:length))
	END SUBROUTINE mirror_malloc

	!> @brief Deallocates, both on CPU and GPU, an array previously dynamically
	!> allocated in a mirrored manner.
	!> @param p The pointer to the dynamically allocated array to deallocate.
	!> @pre The pointer \p p must point to an array that was dynamically allocated
	!> in a mirrored manner, using function mirror_malloc().
	SUBROUTINE mirror_free(p)
		IMPLICIT NONE

		INTEGER, ALLOCATABLE :: p(:)

		! Deallocate from the device
        !$OMP TARGET EXIT DATA MAP(DELETE:p)
		DEALLOCATE(p)
	END SUBROUTINE mirror_free
END PROGRAM main