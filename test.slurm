#!/bin/bash
#SBATCH --job-name=align_mpi_omp             # Job name
#SBATCH --output=logs/out.%N     # Standard output log (%N = node name)
#SBATCH --error=logs/err.%N      # Standard error log
#SBATCH --time=01:00:00                       # Max runtime (adjust as needed)
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

# Run the job using MPI
export OMPI_MCA_btl_tcp_if_include=ibp129s0

srun --mpi=pmix ./align_mpi_omp 20000 0.35 0.2 0.25 50000 1250 1250 50000 1250 1250 50 100 M 4353435
