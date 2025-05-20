/* Write your T-SQL query statement below */
WITH cteDept AS
(
    SELECT 
        department_id,
        SUBSTRING(CONVERT(varchar(10), S.pay_date, 120), 1, 7) AS pay_month,
        AVG(amount) AS dept_avg
    FROM 
        Salary S
        INNER JOIN Employee E ON S.employee_id = E.employee_id
    GROUP BY
        SUBSTRING(CONVERT(varchar(10), S.pay_date, 120), 1, 7),E.department_id
),
cteCompany AS
(
    SELECT 
        
        SUBSTRING(CONVERT(varchar(10), S.pay_date, 120), 1, 7) AS pay_month,
        AVG(amount) AS company_avg
    FROM 
        Salary S
        INNER JOIN Employee E ON S.employee_id = E.employee_id
    GROUP BY
        SUBSTRING(CONVERT(varchar(10), S.pay_date, 120), 1, 7)
)
SELECT
    cteD.pay_month,
    department_id,
    CASE
        WHEN dept_avg>company_avg THEN 'higher'
        WHEN dept_avg<company_avg THEN 'lower'
        ELSE 'same' END AS comparison
FROM
    cteDept cteD
    INNER JOIN cteCompany cteC ON cteD.pay_month=cteC.pay_month
ORDER BY
    cteD.pay_month, cteD.department_id;
