#!/bin/bash

N_RUNS=150  # Numero di esecuzioni
OUTPUT_FILE="tempi.txt"

echo "Eseguo $N_RUNS test e salvo i risultati in $OUTPUT_FILE"
> $OUTPUT_FILE  # Svuota il file prima di scrivere nuovi risultati

for i in $(seq 1 $N_RUNS); do
    # Esegui il programma e prendi solo la riga con "Time:"
    tempo=$(./align_omp 16777216 0.1 0.3 0.35 64 8 2 64 32 2 8388608 4194304 M 609823 | grep "Time:" | awk '{print $2}')
    echo $tempo >> $OUTPUT_FILE  # Salva solo il tempo in tempi.txt
done

echo "Test completati! Tempi salvati in $OUTPUT_FILE"
