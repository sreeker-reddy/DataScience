
WITH cteReqAcc AS
(
    SELECT 
        requester_id AS Id,
        COUNT(*) AS Friends
    FROM 
        RequestAccepted 
    GROUP BY
        requester_id
    
    UNION ALL
    
    SELECT 
        accepter_id AS Id,
        COUNT(*) AS Friends
    FROM 
        RequestAccepted 
    GROUP BY
        accepter_id
)
SELECT TOP 1
    id,
    SUM(Friends) AS num
FROM
    cteReqAcc
GROUP BY
    id
ORDER BY num DESC
