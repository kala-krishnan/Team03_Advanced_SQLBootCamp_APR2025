-----------DAY 7------------------
/*1.     Rank employees by their total sales
(Total sales = Total no of orders handled, JOIN employees and orders table)*/
SELECT 
employee_id,
Employee_Name,

RANK() over(
order by total_sales desc) as rank,
total_sales

FROM
(select e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS Employee_Name,
    COUNT(o.order_id) AS total_sales
    from employees e
    JOIN orders o ON e.employee_id = o.employee_id
    GROUP BY e.employee_id, e.first_name, e.last_name
	) AS employee_sales;
 
/*2.      Compare current order's freight with previous and next order for each customer.
(Display order_id,  customer_id,  order_date,  freight,
Use lead(freight) and lag(freight).*/
select 
    order_id, customer_id, order_date, freight,
    LAG(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_freight,
    LEAD(freight) OVER (PARTITION BY customer_id ORDER BY order_date) AS next_freight
FROM 
    orders;

/*3.     Show products and their price categories, product count in each category, avg price:
        	(HINT:
·  	Create a CTE which should have price_category definition:
        	WHEN unit_price < 20 THEN 'Low Price'
            WHEN unit_price < 50 THEN 'Medium Price'
            ELSE 'High Price'
·  	In the main query display: price_category,  product_count in each price_category,  ROUND(AVG(unit_price)::numeric, 2) as avg_price)
 
 */
 











	