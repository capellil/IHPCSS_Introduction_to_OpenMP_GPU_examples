#!/bin/bash

########
# NOTE #
########
# Lines starting with '#SBATCH' are special comments that SLURM uses to extract
# information about your job. If you insert a space between '#' and 'SBATCH',
# SLURM will think the line is no-longer a special comment and will ignore it.

# The name of the output file
#SBATCH -o output.txt

# The budget account to use
# SBATCH -A=tra210016p

# The reservation to use:
# - on Tuesday evening: ihpcssday2GPU2
# - on Wednesday afternoon / evening: ihpcssday3GPU2
# - on Thursday evening: ihpcssday4GPU2
# This submission script is preset to the reservation for Tuesday evening as it
# will be your first one. Remember to update it the days that follow :)
# If you do *not* use a reservation, simply insert a space between '#' and
# 'SBATCH', it will turn the line into a plain comment.
# SBATCH --res ihpcssday2GPU2

# The partition to use, GPU nodes here
#SBATCH -p GPU-shared

# The type and number of GPUs to use per node (8 per node, so 8 = 1 full node).
# There are 8 GPUs per node, so each GPU is also allocated 1/8th of the all
# resources on the node (1/8th of the RAM, 1/8th of the cores etc...)
# To change the number of GPUs, change the last number --gres=<x>:<y>:<this_one>
#SBATCH --gres=gpu:v100-16:1

# Jobs are capped at 30 seconds (Your code should run for ~10 seconds anyway)
#SBATCH -t 00:00:30

# The number of nodes (at most 2)
#SBATCH -N 1

# The number of MPI processes
export MPI_PROCESS_COUNT=1;

# The number of OpenMP threads. If using MPI, it is the number of OpenMP threads
# per MPI process
export OMP_NUM_THREADS=1;

# Place OpenMP threads on cores
export OMP_PLACES=cores;

# Keep the OpenMP threads where they are
export OMP_PROC_BIND=true;

# Load the modules needed
module load nvhpc/22.9 openmpi/4.0.5-nvhpc22.9

# Compile everything
make

# Execute the program
./bin/dataenvironment
