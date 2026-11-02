"""Découpe un gros CSV en plusieurs parties, en gardant l'en-tête dans chaque partie.
Usage : python decoupe.py 202607-divvy-tripdata.csv 2
Utile car le téléversement local de BigQuery est limité à 100 Mo.
"""
import sys

fichier = sys.argv[1]            # ex : 202607-divvy-tripdata.csv
nb_parties = int(sys.argv[2])    # ex : 2

with open(fichier, encoding="utf-8", newline="") as f:
    entete = f.readline()
    lignes = f.readlines()

taille = -(-len(lignes) // nb_parties)  # division arrondie au supérieur
base = fichier.replace(".csv", "")

for i in range(nb_parties):
    morceau = lignes[i * taille:(i + 1) * taille]
    nom = f"{base}_part{i + 1}.csv"
    with open(nom, "w", encoding="utf-8", newline="") as out:
        out.write(entete)
        out.writelines(morceau)
    print(nom, len(morceau), "lignes")
