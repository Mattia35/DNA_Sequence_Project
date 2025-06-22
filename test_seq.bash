#!/bin/bash

TEMPI_FILE="tempi.txt"
NUM_RUNS=50

# Pulisci il file tempi
> "$TEMPI_FILE"

echo "Esecuzione di $NUM_RUNS run di ./align_seq..."

for i in $(seq 1 $NUM_RUNS); do
    echo "Run $i di $NUM_RUNS..."

    # Esegui il comando e cattura l'output riga per riga
    ./align_seq 3000 0.35 0.2 0.25 40000 10 0 40000 10 0 500 0 M 4353435 | while IFS= read -r line; do
        echo "$line"
        if [[ "$line" == Result:* ]]; then
            break
        fi
    done

    # Attendi che `tempi.txt` venga aggiornato
    while [ "$(wc -l < "$TEMPI_FILE")" -lt "$i" ]; do
        sleep 0.1
    done
done

echo "Tutte le esecuzioni completate. Calcolo della media..."

# Calcola la media
total_time=0
while read -r line; do
    tempo=$(echo "$line" | grep -oP '\d+\.\d+')
    total_time=$(echo "$total_time + $tempo" | bc)
done < "$TEMPI_FILE"

media=$(echo "scale=6; $total_time / $NUM_RUNS" | bc)

echo "Media dei tempi: $media secondi"