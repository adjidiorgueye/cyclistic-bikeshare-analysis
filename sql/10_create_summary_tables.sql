-- Objectif : créer 4 petites tables de synthèse pour Power BI.
-- Les noms commencent par summary_ : pas de conflit avec le joker trips_*.

CREATE OR REPLACE TABLE `PROJET.cyclistic.summary_by_day` AS
SELECT member_casual, day_of_week,
  ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'][OFFSET(day_of_week - 1)] AS jour,
  COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual, day_of_week;

CREATE OR REPLACE TABLE `PROJET.cyclistic.summary_by_hour` AS
SELECT member_casual, EXTRACT(HOUR FROM started_at) AS heure,
  COUNT(*) AS nb_trajets
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual, heure;

-- Exclut les 58 trajets de septembre 2025
CREATE OR REPLACE TABLE `PROJET.cyclistic.summary_by_month` AS
SELECT member_casual, FORMAT_DATE('%Y-%m', DATE(started_at)) AS mois,
  COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min
FROM `PROJET.cyclistic.analysis_trips`
WHERE started_at >= TIMESTAMP('2025-10-01')
GROUP BY member_casual, mois;

CREATE OR REPLACE TABLE `PROJET.cyclistic.summary_top_stations` AS
SELECT start_station_name, COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min
FROM `PROJET.cyclistic.analysis_trips`
WHERE member_casual = 'casual' AND start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY nb_trajets DESC
LIMIT 10;
