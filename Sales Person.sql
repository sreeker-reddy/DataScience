
with RedOnly as (
    select b.sales_id from Company a
    join Orders b on a.com_id = b.com_id
    where a.name = 'RED'
)

select a.name from SalesPerson a
where a.sales_id not in (select sales_id from RedOnly)
