def calcola_media(file_path):
    with open(file_path, "r") as f:
        tempi = [float(line.strip()) for line in f]
    
    media = sum(tempi) / len(tempi)  # Calcolo della media senza NumPy
    print(f"Media dei tempi di esecuzione: {media:.5f} sec")

calcola_media("tempi.txt")
