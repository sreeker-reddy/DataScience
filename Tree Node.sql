/* Write your T-SQL query statement below */
(SELECT 
    id,
    'Root' AS type
FROM
    tree
WHERE 
    p_id IS NULL)

UNION ALL

(SELECT DISTINCT
    t1.id, 
    'Inner' AS type
FROM
    tree t1
    INNER JOIN tree t2 ON t2.p_id=t1.id
WHERE   
    t1.p_id IS NOT NULL)

UNION ALL

(SELECT DISTINCT
    t1.id,
    'Leaf' AS type
FROM 
    tree t1
    LEFT JOIN tree t2 ON t2.p_id = t1.id
WHERE 
    t1.p_id IS NOT NULL AND t2.id IS NULL
)
