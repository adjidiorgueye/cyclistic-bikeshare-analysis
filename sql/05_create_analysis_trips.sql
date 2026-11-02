-- Objectif : choisir les seuils de durée, puis créer la table d'analyse.
-- Les seuils (1 min et 24 h) sont un choix d'analyste, à justifier dans la documentation.

-- 1. Mesurer les trajets très courts et très longs
SELECT
  COUNTIF(ride_length_min < 1) AS moins_1_min,
  COUNTIF(ride_length_min < 2) AS moins_2_min,
  COUNTIF(ride_length_min > 720) AS plus_12_h,
  COUNTIF(ride_length_min > 1440) AS plus_24_h,
  COUNT(*) AS total
FROM `PROJET.cyclistic.trips_clean`;

-- 2. Table d'analyse : trajets de 1 minute à 24 heures
CREATE OR REPLACE TABLE `PROJET.cyclistic.analysis_trips` AS
SELECT *
FROM `PROJET.cyclistic.trips_clean`
WHERE ride_length_min >= 1
  AND ride_length_min <= 1440;

-- 3. Contrôle (résultat de ce projet : 6 007 212 trajets)
SELECT
  COUNT(*) AS nb_trajets,
  MIN(ride_length_min) AS duree_min,
  MAX(ride_length_min) AS duree_max
FROM `PROJET.cyclistic.analysis_trips`;
