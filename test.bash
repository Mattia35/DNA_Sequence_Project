#!/bin/bash

# File per salvare i tempi
TEMPI_FILE="tempi.txt"
LOG_FILE="$HOME/Embedded/logs/out.0"
total_time=0

# Numero di esecuzioni
NUM_RUNS=50

# Pulisce i file all'inizio
> "$TEMPI_FILE"
> "$LOG_FILE"

for i in $(seq 1 $NUM_RUNS); do
    echo "Esecuzione $i di $NUM_RUNS..."

    # Lancia il job tramite Slurm
    sbatch test.slurm > /dev/null 2>&1

    # Attendi che il file log venga popolato con un nuovo Time:
    while true; do
        if grep -q "Time:" "$LOG_FILE"; then
            break
        fi
        sleep 0.1
    done

    # Estrai il tempo
    TEMPO=$(grep -oP 'Time: \K[0-9.]+' "$LOG_FILE")

    # Salva nel file dei tempi
    echo "$TEMPO" >> "$TEMPI_FILE"

    # Somma
    total_time=$(echo "$total_time + $TEMPO" | bc)

    # Pulisce il file per l'iterazione successiva
    > "$LOG_FILE"
done

# Calcola la media
tempo_medio=$(echo "scale=6; $total_time / $NUM_RUNS" | bc)

# Stampa risultato finale
echo "Test completati!"
echo "Media dei tempi: $tempo_medio secondi"
