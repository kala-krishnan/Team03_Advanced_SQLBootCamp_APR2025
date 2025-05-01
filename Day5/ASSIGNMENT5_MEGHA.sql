--------------------ASSIGNMENT 5----------------------
/* 1.      GROUP BY with WHERE - Orders by Year and Quarter
Display, order year, quarter, order count, avg freight cost only for those orders where freight cost > 100*/
select
order_date,
EXTRACT(YEAR FROM order_date) AS order_year,
EXTRACT(QUARTER FROM order_date) AS order_quarter,
COUNT(*) AS order_count,
AVG(freight) AS avg_freight_cost
FROM public.orders
WHERE
    freight > 100
GROUP BY
    orders.order_date,
    order_year,
    order_quarter
ORDER BY
    order_year,
    order_quarter;	
	
/* 2.      GROUP BY with HAVING - High Volume Ship Regions
Display, ship region, no of orders in each region, min and max freight cost
 Filter regions where no of orders >= 5 */
 select ship_region,
 COUNT(order_id) AS order_count,
 min(freight) as mnm_freight,
 max(freight) as mxm_freight
 FROM
 orders
 group by ship_region
HAVING
 COUNT(order_id) >= 5
order BY ship_region;

/*3.      Get all title designations across employees and customers ( Try UNION & UNION ALL)*/
SELECT title AS designation
FROM employees --gives 9 rows

SELECT contact_title AS designation
FROM customers -- gives 90 rows
---try UNION ,,will remove duplicate
SELECT contact_title AS designation
FROM customers
UNION
select title as designation
from employees-- gives 14 rows, by removing duplicates

 -- UNION ALL includes all rows, including duplicates

SELECT contact_title AS designation
FROM customers
UNION ALL
select title as designation
from employees -- all 99 rows are displayed


/*4.      Find categories that have both discontinued and in-stock products
(Display category_id, instock means units_in_stock > 0, Intersect)*/
SELECT category_id,
units_in_stock as instock
FROM products
 WHERE discontinued =  1 and units_in_stock > --without using intersect
                     
---INTERSECT---
SELECT category_id,
units_in_stock as instock
FROM products
where units_in_stock > 0
intersect
SELECT category_id,
units_in_stock as instock
FROM products
 WHERE discontinued =  1;


/*5.      Find orders that have no discounted items (Display the  order_id, EXCEPT)*/
SELECT order_id
FROM Order_details

EXCEPT

SELECT order_id
FROM Order_details
WHERE discount>0

 
 
