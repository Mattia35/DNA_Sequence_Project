#!/bin/bash

N_RUNS=150  # Numero di esecuzioni
OUTPUT_FILE="tempi.txt"

echo "Eseguo $N_RUNS test e salvo la media in $OUTPUT_FILE"
> $OUTPUT_FILE  # Svuota il file prima di scrivere nuovi risultati

total_time=0  # Variabile per la somma dei tempi

for i in $(seq 1 $N_RUNS); do
    # Esegui il programma e prendi solo la riga con "Time:"
    tempo=$(./align_omp 16777216 0.1 0.3 0.35 64 8 2 64 32 2 8388608 4194304 M 609823 | grep "Time:" | awk '{print $2}')
    total_time=$(echo "$total_time + $tempo" | bc)  # Somma i tempi
  
done

# Calcola la media
tempo_medio=$(echo "scale=6; $total_time / $N_RUNS" | bc)

echo "$tempo_medio" > $OUTPUT_FILE  # Salva solo la media nel file

echo "Test completati! Media salvata in $OUTPUT_FILE"
