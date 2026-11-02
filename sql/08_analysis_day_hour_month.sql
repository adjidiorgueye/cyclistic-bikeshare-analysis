-- Objectif : comparer membres et occasionnels par jour, heure et mois.
-- day_of_week : 1 = dimanche, 7 = samedi.
-- Les heures sont lues telles quelles (hypothèse : heure locale de Chicago).

-- Par jour de la semaine
SELECT member_casual, day_of_week,
  COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;

-- Par heure de départ
SELECT member_casual,
  EXTRACT(HOUR FROM started_at) AS heure,
  COUNT(*) AS nb_trajets
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual, heure
ORDER BY member_casual, heure;

-- Par mois (septembre 2025 contient 58 trajets qui ont commencé fin septembre)
SELECT member_casual,
  FORMAT_DATE('%Y-%m', DATE(started_at)) AS mois,
  COUNT(*) AS nb_trajets,
  ROUND(AVG(ride_length_min), 1) AS duree_moyenne_min
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual, mois
ORDER BY member_casual, mois;

-- Part des trajets des occasionnels en été (juin à août) : environ 46,4 %
-- (à lancer après 10_create_summary_tables.sql)
SELECT
  ROUND(100 * SUM(IF(mois IN ('2026-06','2026-07','2026-08'), nb_trajets, 0)) / SUM(nb_trajets), 1) AS pct_ete
FROM `PROJET.cyclistic.summary_by_month`
WHERE member_casual = 'casual';
