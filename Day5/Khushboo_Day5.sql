                                --Day-5
--1.GROUP BY with WHERE - Orders by Year and Quarter
--Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100
Select
Extract(YEAR FROM order_date) As order_year,
Extract(QUARTER FROM order_date) As quarter,
count (*) As orcount,
Avg(freight) As avgfreight
from orders
where freight>100
group by extract(YEAR FROM order_date),Extract(QUARTER FROM order_date)
order by order_year, quarter;

--2.      GROUP BY with HAVING - High Volume Ship Regions
--Display, ship region, no of orders in each region, min and max freight cost
 --Filter regions where no of orders >= 5
select ship_region,count(order_id),min(freight),max(freight) from orders
group by ship_region having count(order_id) >=5

	--3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)
	Select title from employees union Select contact_title from customers;
	Select title from employees union all  Select contact_title from customers;

--4.      Find categories that have both discontinued and in-stock products
--(Display category_id, instock means units_in_stock > 0, Intersect)
Select *from categories;
Select *from products;	
Select *from order_details;
 select category_id from products where discontinued =1 
Intersect select category_id from products where units_in_stock >0


--5.Find orders that have no discounted items (Display the  order_id, EXCEPT)

SELECT order_id
FROM orders
EXCEPT
SELECT order_id
FROM order_details
Where discount>0;
