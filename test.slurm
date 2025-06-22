#!/bin/bash
#SBATCH --partition=multicore
#SBATCH --job-name=align_mpi_omp             # Job name
#SBATCH --output=logs/out.0     # Standard output log (%N = node name)
#SBATCH --error=logs/err.0      # Standard error log
#SBATCH --time=01:00:00                       # Max runtime (adjust as needed)
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

# Run the job using MPI
export OMPI_MCA_btl_tcp_if_include=ibp129s0

srun --mpi=pmix ./align_mpi_omp 3000 0.35 0.2 0.25 40000 10 0 40000 10 0 500 0 M 4353435
