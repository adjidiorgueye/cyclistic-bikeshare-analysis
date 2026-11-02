-- Objectif : examiner les doublons.
-- Constat dans ce projet : 6 171 785 lignes, 6 171 750 ride_id uniques,
-- 6 171 750 lignes distinctes => 35 doublons exacts (déduit par calcul).

-- 1. ride_id présents plusieurs fois
SELECT ride_id, COUNT(*) AS n
FROM `PROJET.cyclistic.trips_all`
GROUP BY ride_id
HAVING COUNT(*) > 1
ORDER BY n DESC
LIMIT 20;

-- 2. Les lignes sont-elles entièrement identiques ?
SELECT
  (SELECT COUNT(*) FROM `PROJET.cyclistic.trips_all`) AS nb_lignes,
  (SELECT COUNT(*) FROM (SELECT DISTINCT * FROM `PROJET.cyclistic.trips_all`)) AS nb_lignes_distinctes;

-- 3. Contrôle direct des paires (à lancer pour confirmer visuellement)
SELECT *
FROM `PROJET.cyclistic.trips_all`
WHERE ride_id IN (
  SELECT ride_id FROM `PROJET.cyclistic.trips_all`
  GROUP BY ride_id HAVING COUNT(*) > 1
)
ORDER BY ride_id
LIMIT 20;
