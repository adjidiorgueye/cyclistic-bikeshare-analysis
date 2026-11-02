-- Objectif : 10 stations de départ les plus utilisées par les occasionnels.
-- Limite : exclut les trajets sans station de départ (surtout des vélos électriques).
SELECT
  start_station_name,
  COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min
FROM `PROJET.cyclistic.analysis_trips`
WHERE member_casual = 'casual'
  AND start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY nb_trajets DESC
LIMIT 10;
