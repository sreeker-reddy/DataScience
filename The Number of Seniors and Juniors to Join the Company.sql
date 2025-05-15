/* Write your T-SQL query statement below */
with s1 as(
    select employee_id, salary, sum(salary) over (order by salary,employee_id) rs
    from Candidates
    where experience='Senior'
),
s2 as(
    select count(employee_id) senior,max(rs) as used
    from s1
    where rs<=70000
),
j1 as(
    select employee_id, salary, sum(salary) over (order by salary,employee_id) rs
    from Candidates
    where experience='Junior'
),
j2 as(
    select count(employee_id) as Junior
    from j1
    where rs<=(select 70000-isnull(used,0) from s2)
)
select 'Senior' as experience, (select senior from s2) as accepted_candidates
union all
select 'Junior' as experience, (select Junior from j2) as accepted_candidates
