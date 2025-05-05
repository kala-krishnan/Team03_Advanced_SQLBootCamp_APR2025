--1.     Rank employees by their total sales
--(Total sales = Total no of orders handled, JOIN employees and orders table)
 
select employee_id ,count(order_id), rank() over (order by count(order_id) desc) as rank_employee
from orders group by employee_id

--2.      Compare current order's freight with previous and next order for each customer.
--(Display order_id,  customer_id,  order_date,  freight,
--Use lead(freight) and lag(freight).


select order_id,customer_id,order_date,freight,lag(freight, 1,0) over(order by order_date) as previous_freight,
lead(freight,1,0) over(order by order_date) as next_freight from orders


--3.     Show products and their price categories, product count in each category, avg price:
  --      	(HINT: Create a CTE which should have price_category definition:
    --    	WHEN unit_price < 20 THEN 'Low Price'
      --      WHEN unit_price < 50 THEN 'Medium Price'
        --    ELSE 'High Price'
-- 	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
with price_category_calc as 
(select product_id,unit_price,
case when unit_price <20 then 'Low_Price'
when unit_price < 50 then 'Medium Price'
else 'High Price'
end as Price_Category
from products)

select pc.Price_Category,count(pr.product_id),round(avg(pr.unit_price) :: numeric,2) as avg_price
from price_category_calc pc join products pr
on pc.product_id = pr.product_id group by pc.Price_Category