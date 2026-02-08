# Parallel Genetic Sequence Alignment

This academic project focuses on **parallelizing a DNA sequence alignment program** originally implemented in `align.c`. Two parallel versions have been implemented:

- **CUDA**: GPU-based parallelization  
- **MPI + OpenMP**: hybrid CPU parallelization using distributed and shared memory  

The goal is to demonstrate practical parallel computing techniques and evaluate performance on different hardware platforms.

## Requirements

To compile and run the project, the following tools are required:

| Tool          | Purpose |
|---------------|---------|
| `gcc` or `clang` | Compile C code (sequential and OpenMP support) |
| `mpicc`       | Compile MPI and MPI + OpenMP version |
| `nvcc`        | Compile CUDA version (NVIDIA GPU required) |
| `make`        | Build automation using the provided Makefile |

> **Notes for Mac users**:  
> - OpenMP requires LLVM via Homebrew:  
> ```bash
> brew install llvm
> export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
> ```  
> - CUDA is **not available on Apple Silicon**, so the CUDA target cannot be built on Mac.

## Compilation

All versions can be compiled using the provided **Makefile**:

```bash
# Build all available versions
make all

# Build only MPI + OpenMP hybrid version
make align_mpi_omp

# Build only CUDA version (if NVIDIA GPU available)
make align_cuda

# Build in debug mode (with verbose output)
make debug

# Remove all binaries
make clean
