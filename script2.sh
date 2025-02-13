#!/bin/bash

# File di output per i tempi
TEMPI_FILE="tempi.txt"
LOG_FILE="$HOME/Embedded/logs/out.0"

# Svuota il file tempi.txt all'inizio
> "$TEMPI_FILE"

# Esegui il job 150 volte
for i in {1..150}; do
    echo "Esecuzione $i di 150..."
    
    # Sottometti il job
    condor_submit job.job > /dev/null 2>&1

    # Attendi che il file ~/logs/out.0 venga aggiornato con un nuovo risultato
    while true; do
        if grep -q "Time:" "$LOG_FILE"; then
            break
        fi
        sleep 0.1  # Aspetta 100ms prima di controllare di nuovo
    done

    # Estrai il tempo dall'output
    TEMPO=$(grep -oP 'Time: \K[0-9.]+' "$LOG_FILE")

    # Salva il tempo nel file
    echo "$TEMPO" >> "$TEMPI_FILE"

    echo "Tempo registrato: $TEMPO"
    
    # Pulizia del log per evitare di leggere vecchi valori
    > "$LOG_FILE"
done

echo "Tutti i tempi sono stati salvati in $TEMPI_FILE"
