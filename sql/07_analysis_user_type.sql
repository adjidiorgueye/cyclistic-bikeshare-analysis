-- Objectif : nombre de trajets, durée moyenne et médiane par type d'usager.
-- La médiane est approximative (APPROX_QUANTILES).
SELECT
  member_casual,
  COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min,
  ROUND(APPROX_QUANTILES(ride_length_min, 100)[OFFSET(50)], 1) AS duree_mediane_min
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual;
