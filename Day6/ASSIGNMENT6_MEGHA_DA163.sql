-----------Day 6------------
/*1.      Categorize products by stock status
(Display product_name, a new column stock_status whose values are based on below condition
 units_in_stock = 0  is 'Out of Stock'
       units_in_stock < 20  is 'Low Stock')*/
SELECT product_name,
CASE
  WHEN  units_in_stock = 0 THEN 'Out of Stock'
  WHEN  units_in_stock < 20 THEN 'Low Stock'
  ELSE 'Instock'
  END 
  AS stock_status
FROM products;
	   
 
/*2.      Find All Products in Beverages Category(Subquery, Display product_name,unitprice)*/

/*SELECT p.Product_name,p.unit_price,c.category_name
FROM products p
join categories c on p.category_id=c.category_id;
WHERE category_id = (
  SELECT category_id
  FROM categories
  WHERE category_name = 'Beverages')*/  --    RECHECK  THE QUERY MEGHA..
  
 SELECT product_name, unit_price
FROM Products 
WHERE category_id IN (
            SELECT category_id
			FROM Categories 
			WHERE Category_name = 'Beverages'
)

/*3.      Find Orders by Employee with Most Sales
(Display order_id,   order_date,  freight, employee_id.
Employee with Most Sales=Get the total no.of of orders for each employee then order by DESC and limit 1. Use Subquery)
 */
 SELECT order_id, employee_id, order_date, freight
FROM Orders
WHERE employee_id = (
                  SELECT employee_id
				  FROM Orders
				  GROUP BY employee_id
				  ORDER BY 
				    COUNT(order_id) DESC
				  LIMIT 1
				  )
/*4.      Find orders  where for country!= ‘USA’ with freight costs higher than any order from USA. (Subquery, Try with ANY, ALL operators)
 */
 
 --USING ANY OPERATOR
SELECT order_id, freight, ship_country
FROM Orders
WHERE ship_country!='USA' AND
      freight > ANY (
                    SELECT freight
					FROM Orders
					WHERE ship_country='USA' 
					 )
ORDER BY freight

--USING ALL OPERATOR
SELECT order_id, freight, ship_country
FROM Orders
WHERE ship_country!='USA' AND
      freight > ALL (
                    SELECT freight
					FROM Orders
					WHERE ship_country='USA' 
					 )
ORDER BY freight


