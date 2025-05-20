/* Write your T-SQL query statement below */
WITH cteSuccess AS
(
    SELECT 
        DATEADD(DAY,-rn,success_date) AS success_group_date,
        success_date
    FROM
    (
        SELECT
            ROW_NUMBER() OVER(ORDER BY success_date ASC) AS rn,
            success_date
    FROM 
        Succeeded
    WHERE 
        success_date BETWEEN '2019-01-01' AND '2019-12-31') S
),
cteFail AS
(
    SELECT 
        DATEADD(DAY,-rn,fail_date) AS fail_group_date,
        fail_date
    FROM
    (
        SELECT
            ROW_NUMBER() OVER(ORDER BY fail_date ASC) AS rn,
            fail_date
    FROM 
        Failed
    WHERE 
        fail_date BETWEEN '2019-01-01' AND '2019-12-31') F
)
SELECT
    'succeeded' AS period_state,
    MIN(success_date) AS start_date,
    MAX(success_date) AS end_date
FROM 
    cteSuccess
GROUP BY 
    success_group_date
UNION ALL
SELECT
    'failed' AS period_state,
    MIN(fail_date) AS start_date,
    MAX(fail_date) AS end_date
FROM 
    cteFail
GROUP BY 
    fail_group_date

ORDER BY start_date ASC
