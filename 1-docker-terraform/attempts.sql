-- For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', 
-- exclusive of the upper bound), how many trips had a trip_distance of less than or equal to 1 mile?
SELECT SUM(cnt)
FROM (
    SELECT 
        CAST(lpep_pickup_datetime AS DATE) AS "days", 
        COUNT(*) AS cnt
    FROM
        ny_taxi_green
    WHERE
        trip_distance <= 1.0 AND (CAST(lpep_pickup_datetime AS DATE) BETWEEN '2025-11-01' AND '2025-11-30')
    GROUP BY
        CAST(lpep_pickup_datetime AS DATE)
);


-- Which was the pick up day with the longest trip distance? Only consider trips with trip_distance 
-- less than 100 miles (to exclude data errors).
-- Use the pick up time for your calculations.
SELECT days, max_trip_dist
FROM (
	SELECT 
		CAST(lpep_pickup_datetime AS DATE) AS days,
		MAX(trip_distance) AS max_trip_dist
	FROM
		ny_taxi_green
	WHERE
		trip_distance < 100 AND (CAST(lpep_pickup_datetime AS DATE) BETWEEN '2025-11-01' AND '2025-11-30')
	GROUP BY
		days
) 
ORDER BY max_trip_dist DESC
LIMIT 1;


-- Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?
SELECT 
	zpu."Zone", SUM(t."total_amount") AS sum_amount
FROM 
	ny_taxi_green t
LEFT JOIN 
	lookup zpu ON t."PULocationID" = zpu."LocationID"
WHERE
	CAST(t."lpep_pickup_datetime" AS DATE) = '2025-11-18'
GROUP BY
	zpu."Zone"
ORDER BY 
	sum_amount DESC


-- For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?
-- Note: it's tip , not trip. We need the name of the zone, not the ID.
SELECT 
	z_t_do."Zone",
	MAX(t."tip_amount") AS max_tips
FROM 
	ny_taxi_green t
LEFT JOIN 
	lookup z_t_pu ON t."PULocationID" = z_t_pu."LocationID"
LEFT JOIN
	lookup z_t_do ON t."DOLocationID" = z_t_do."LocationID"
WHERE
	z_t_pu."Zone" = 'East Harlem North' AND
	(
		CAST(t.lpep_pickup_datetime AS DATE) BETWEEN '2025-11-01' AND '2025-11-30'
	)
GROUP BY
	z_t_do."Zone"
ORDER BY
	max_tips DESC