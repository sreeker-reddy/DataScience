CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    DECLARE @result INT;

    SELECT @result = Salary
    FROM (
        SELECT DISTINCT Salary
        FROM Employee
        ORDER BY Salary DESC
        OFFSET @N - 1 ROWS FETCH NEXT 1 ROWS ONLY
    ) AS RankedSalaries;

    RETURN @result;
END
