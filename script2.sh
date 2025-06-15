#!/bin/bash

# File di output per i tempi
TEMPI_FILE="tempi.txt"
LOG_FILE="$HOME/Embedded/logs/out.0"
total_time=0
# Svuota il file tempi.txt all'inizio
> "$TEMPI_FILE"

# Esegui il job 50 volte
for i in {1..50}; do
    echo "Esecuzione $i di 50..."
    
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

    # Somma dei tempi
    total_time=$(echo "$total_time + $TEMPO" | bc)
    # Pulizia del log per evitare di leggere vecchi valori
    > "$LOG_FILE"
done

# Calcolo della media 
tempo_medio=$(echo "scale=6; $total_time / 50" | bc)

# Stampa valori
echo "Test completati! La media è: $tempo_medio"
