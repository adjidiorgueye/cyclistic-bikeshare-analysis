-- Objectif : assembler toutes les tables mensuelles (trips_*) en une table brute,
-- et ajouter ride_length_min (durée en minutes) et day_of_week (1 = dimanche, 7 = samedi).
-- ATTENTION : à lancer UNE SEULE FOIS. Si trips_all existe déjà, elle serait
-- capturée par le joker trips_* et les données seraient dupliquées.
CREATE OR REPLACE TABLE `PROJET.cyclistic.trips_all` AS
SELECT
  *,
  TIMESTAMP_DIFF(ended_at, started_at, SECOND) / 60 AS ride_length_min,
  EXTRACT(DAYOFWEEK FROM started_at) AS day_of_week
FROM `PROJET.cyclistic.trips_*`;

-- Contrôle : nombre de trajets et d'identifiants uniques
SELECT COUNT(*) AS nb_trajets, COUNT(DISTINCT ride_id) AS nb_ride_id_uniques
FROM `PROJET.cyclistic.trips_all`;
