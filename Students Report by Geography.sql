/* Write your T-SQL query statement below */
SELECT America, Asia, Europe 
FROM (
    SELECT ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name ASC) AS row_number,
           name, continent
    FROM Student
) AS SourceTable
PIVOT (  
    MIN(name)  
    FOR continent IN (America, Asia, Europe)  
) AS PivotTable 
