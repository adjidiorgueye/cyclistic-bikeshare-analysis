-- Objectif : supprimer les doublons exacts et les trajets de durée invalide.
-- trips_all (brute) n'est pas modifiée.
CREATE OR REPLACE TABLE `PROJET.cyclistic.trips_clean` AS
SELECT DISTINCT *
FROM `PROJET.cyclistic.trips_all`
WHERE started_at IS NOT NULL
  AND ended_at IS NOT NULL
  AND ride_length_min > 0;

-- Contrôle (résultat de ce projet : 6 169 748 / 6 169 748 / 0,0167 / 1 559,95)
SELECT
  COUNT(*) AS nb_trajets_clean,
  COUNT(DISTINCT ride_id) AS nb_ride_id_uniques,
  MIN(ride_length_min) AS duree_min,
  MAX(ride_length_min) AS duree_max
FROM `PROJET.cyclistic.trips_clean`;
