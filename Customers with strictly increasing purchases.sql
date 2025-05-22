/* Write your T-SQL query statement below */
with aa as (select customer_id, datepart(year,order_date) as year,sum(price) as purchase
from orders
group by customer_id, datepart(year,order_date))
, bb as (select customer_id,
 Lead(year) over (partition by customer_id order by year)-year as yeardiff,
 Lead(purchase) over (partition by customer_id order by year)-purchase as purchasediff
 from aa )
, cc as (Select customer_id 
 from bb where yeardiff>1 OR Purchasediff<=0 )

 Select distinct customer_id from orders
 where customer_id not in (Select * from cc)
 
