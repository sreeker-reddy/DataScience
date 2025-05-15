/* Write your T-SQL query statement below */
SELECT
    Department,
    Employee,
    Salary
FROM
(SELECT
    D.name AS [Department],
    E.name AS [Employee],
    E.salary AS [Salary],
    DENSE_RANK() OVER(PARTITION BY D.id ORDER BY salary DESC) AS rnk
FROM
    Employee E
    INNER JOIN Department D ON E.departmentId = D.id) ED
WHERE
    rnk<=3
