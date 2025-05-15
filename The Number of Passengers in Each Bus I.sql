;WITH cteBuses AS (
    SELECT 
        bus_id AS busID,
        LAG(arrival_time) OVER(ORDER BY arrival_time) AS prevAT,
        arrival_time AS currentAT
    FROM Buses
)
SELECT 
    B.busID AS bus_id,
    COUNT(P.passenger_id) AS passengers_cnt
FROM 
    cteBuses B
    LEFT JOIN Passengers P 
        ON P.arrival_time > ISNULL(B.prevAT, -1) 
        AND P.arrival_time <= B.currentAT
GROUP BY
    B.busID
