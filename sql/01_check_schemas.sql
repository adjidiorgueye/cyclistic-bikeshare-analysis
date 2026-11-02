-- Objectif : vérifier que les types de colonnes sont corrects dans toutes les tables chargées.
-- Remplacer PROJET par l'ID de votre projet Google Cloud.
-- Résultat attendu : aucune ligne (aucune anomalie de type).
SELECT table_name, column_name, data_type
FROM `PROJET.cyclistic.INFORMATION_SCHEMA.COLUMNS`
WHERE column_name IN ('started_at', 'ended_at', 'start_lat', 'end_lat')
  AND data_type NOT IN ('TIMESTAMP', 'FLOAT64')
ORDER BY table_name;

-- Nombre de tables et de tables dont le nom contient un tiret (doit valoir 0)
SELECT
  COUNT(*) AS nb_tables,
  COUNTIF(table_name LIKE 'trips-%') AS nb_avec_tiret
FROM `PROJET.cyclistic.INFORMATION_SCHEMA.TABLES`;
