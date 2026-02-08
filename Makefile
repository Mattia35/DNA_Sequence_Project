#
# Exact genetic sequence alignment
#
# Parallel Computing
# Degree in Computer Engineering
# Academic Year 2023/2024
#
# (c) 2024 Arturo Gonzalez-Escribano
# Grupo Trasgo, Universidad de Valladolid (Spain)
#

# --------------------------------------------------
# System detection
# --------------------------------------------------
UNAME_S := $(shell uname -s)

# --------------------------------------------------
# Compilers
# --------------------------------------------------
CC      = gcc
MPICC   = mpicc
CUDACC  = nvcc

# --------------------------------------------------
# Flags
# --------------------------------------------------
FLAGS     = -O3 -Wall
OMPFLAG   = -fopenmp
LIBS      = -lm
CUDAFLAGS = -O3 -Xcompiler -Wall

# macOS-specific settings (LLVM via Homebrew)
ifeq ($(UNAME_S), Darwin)
	CC = /opt/homebrew/opt/llvm/bin/clang
	FLAGS += -I/opt/homebrew/opt/llvm/include \
	         -L/opt/homebrew/opt/llvm/lib
	OMPFLAG = -fopenmp -lomp
endif

# --------------------------------------------------
# Targets
# --------------------------------------------------
TARGETS = \
	align_seq \
	align_mpi_omp \
	align_cuda

# --------------------------------------------------
# Default target
# --------------------------------------------------
all: $(TARGETS)

# --------------------------------------------------
# Build rules (rng.c is included inside the .c files)
# --------------------------------------------------

# Sequential version
align_seq: align.c
	$(CC) $(FLAGS) $(DEBUG) align.c $(LIBS) -o $@

# OpenMP version
align_omp: align_omp.c
	$(CC) $(FLAGS) $(DEBUG) $(OMPFLAG) align_omp.c $(LIBS) -o $@

# MPI version
align_mpi: align_mpi.c
	$(MPICC) $(FLAGS) $(DEBUG) align_mpi.c $(LIBS) -o $@

# MPI + OpenMP hybrid version
align_mpi_omp: align_mpi_omp.c
	$(MPICC) $(FLAGS) $(DEBUG) $(OMPFLAG) align_mpi_omp.c $(LIBS) -o $@

# CUDA version
align_cuda: align_cuda.cu
	$(CUDACC) $(CUDAFLAGS) $(DEBUG) align_cuda.cu $(LIBS) -o $@

# --------------------------------------------------
# Debug build
# --------------------------------------------------
debug:
	$(MAKE) DEBUG="-DDEBUG -g" all

# --------------------------------------------------
# Clean
# --------------------------------------------------
clean:
	rm -f $(TARGETS)

# --------------------------------------------------
# Help
# --------------------------------------------------
help:
	@echo
	@echo "Exact genetic sequence alignment"
	@echo
	@echo "Available targets:"
	@echo "  make align_seq       Build sequential version"
	@echo "  make align_omp       Build OpenMP version"
	@echo "  make align_mpi       Build MPI version"
	@echo "  make align_mpi_omp   Build hybrid MPI + OpenMP version"
	@echo "  make align_cuda      Build CUDA version (requires NVIDIA GPU)"
	@echo
	@echo "  make all             Build all versions"
	@echo "  make debug           Build all versions with debug flags"
	@echo "  make clean           Remove all binaries"
	@echo