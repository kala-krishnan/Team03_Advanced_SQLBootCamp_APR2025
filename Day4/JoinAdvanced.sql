--1      List all customers and the products they ordered with the order date. (Inner join)
--Tables used: customers, orders, order_details, products
--Output should have below columns:
  --  companyname AS customer,
  --  orderid,
   -- productname,
    --quantity,
    --orderdate
select * from customers
select * from products
select * from order_details
select * from orders
select * from shippers

select c.company_name as customer,o.order_id,pr.product_name,ord.quantity,o.order_date from customers c inner join orders o 
ON c.customer_id = o.customer_id
inner join order_details ord on ord.order_id = o.order_id
inner join products pr ON pr.product_id=ord.product_id;
 
--2.     Show each order with customer, employee, shipper, and product info — even if some parts are missing. (Left Join)
--Tables used: orders, customers, employees, shippers, order_details, products

select o.order_id,o.employee_id,o.customer_id,o.ship_via,ord.product_id from orders o left join customers c on c.customer_id = o.customer_id
left join employees ON employees.employee_id = o.employee_id
left join order_details ord on ord.order_id = o.order_id
left join products ON products.product_id = ord.product_id
left join shippers on shippers.shipper_id = o.ship_via

--3.     Show all order details and products (include all products even if they were never ordered). (Right Join)
--Tables used: order_details, products
--Output should have below columns:
  --  orderid,
    --productid,
    --quantity,
    --productname
select o.order_id,pr.product_id,pr.product_name ,o.quantity 
from order_details o right join products pr on pr.product_id = o.product_id


 select order_id from order_details where order_id = 10248;
 
 --4. 	List all product categories and their products 
-- including categories that have no products, and products that are not assigned to any category.(Outer Join)
--Tables used: categories, products

select pr.product_id,c.category_id,pr.product_name
from categories c full outer join products pr on c.category_id = pr.category_id

--5. 	Show all possible product and category combinations (Cross join).

select pr.product_id,pr.product_name,ca.category_id,ca.category_name from products pr cross join categories ca

--6. 	Show all employees and their manager(Self join(left join))

select e.first_name || e.last_name as emp_name,
m.first_name || m.last_name as 
manager_name from employees e left join employees m on e.reports_to = m.employee_id;

----7. 	List all customers who have not selected a shipping method.
--Tables used: customers, orders
--(Left Join, WHERE o.shipvia IS NULL)
select from customers c left join orders o on c.customer_id = o.customer_id
where o.ship_via is null
