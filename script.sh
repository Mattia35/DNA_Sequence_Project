#!/bin/bash

N_RUNS=50  # Numero di esecuzioni
OUTPUT_FILE="tempi.txt"

echo "Eseguo $N_RUNS test e salvo la media in $OUTPUT_FILE"
> $OUTPUT_FILE  # Svuota il file prima di scrivere nuovi risultati

total_time=0  # Variabile per la somma dei tempi

for i in $(seq 1 $N_RUNS); do
    echo "eseguo numero $i"
    # Esegui il programma e prendi solo la riga con "Time:"
    tempo=$(srun --partition=students --gpus=1 --cpus-per-task=1 --nodes=1 mpirun -np 4 --oversubscribe main_mpi_cuda.out 3000 0.35 0.2 0.25 40000 10 0 40000 10 0 500 0 M 4353435 | grep "Time:" | awk '{print $2}')
    total_time=$(echo "$total_time + $tempo" | bc)  # Somma i tempi
  
done

# Calcola la media
tempo_medio=$(echo "scale=6; $total_time / $N_RUNS" | bc)

echo "$tempo_medio" > $OUTPUT_FILE  # Salva solo la media nel file

echo "Test completati! Media salvata in $OUTPUT_FILE"

echo "Media: $tempo_medio"
