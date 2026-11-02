-- Objectif : vérifier les valeurs possibles de member_casual et rideable_type,
-- et compter les valeurs manquantes (stations, coordonnées).
SELECT
  member_casual,
  rideable_type,
  COUNT(*) AS nb_trajets,
  COUNTIF(start_station_name IS NULL) AS sans_station_depart,
  COUNTIF(end_lat IS NULL) AS sans_coord_fin
FROM `PROJET.cyclistic.analysis_trips`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, rideable_type;
