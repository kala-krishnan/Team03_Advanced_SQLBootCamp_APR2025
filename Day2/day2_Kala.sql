---Question 1 :Alter Table

select * from employees;
-- Step 1. Alter table with new column
alter table employees
add column linkedin_profile varchar;

-- Step 2. Alter table with new column data type from varchar to text
alter table employees
alter column linkedin_profile type text;

-- Step 3. update new column value
update employees
set linkedin_profile='https://www.linkedln.com/anne'
where employeeid=9

-- Step 4. Alter table constraints
alter table employees
alter column linkedin_profile set not null;

-- Step 5. Alter table constraints by adding unique
alter table employees
add constraint unique_linkedlin_prof unique(linkedin_profile);

--Step 6. Alter table by dropping the column
alter table employees
drop column linkedin_profile;

DISCARD PLANS;

--question 2 : Select Query 

--1. Retrieve the employee name and title of all employees
select * from employees;

select employeename,title from employees; 

--2.Find all unique unit prices of products
select * from Products;

select distinct unitprice as price from products;

--3 List all customers sorted by company name in ascending order
select * from customers;

select customername from customers order by customername

--4 Display product name and unit price, but rename the unit_price column as price_in_usd

select * from Products;

select productname,unitprice as price_in_usd from products

--Question 3 : Filtering

--1 Get all customers from Germany.
 
 select * from customers where country ='Germany';
 
 --2 Find all customers from France or Spain

select * from customers where country in('France','Spain');

--3.Retrieve all orders placed in 2014(based on order_date), 
--and either have freight greater than 50 or 
--the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))

select * from orders

select * from orders where (extract(year from orderdate) = 2014) and 
(freight > 50 or shippeddate is not null);

--4  Retrieve the product_id, product_name, 
--and unit_price of products where the unit_price is greater than 15.

select productid,productname,unitprice from products where unitprice >15;

-- 5 List all employees who are located in the USA and have the
--title "Sales Representative".

select * from employees where country ='USA' and title ='Sales Representative'

--6 Retrieve all products that are not discontinued and priced greater than 30.

select * from products

select * from products where discontinued = 0 and unitprice > 30

--7 List all customers who are either Sales Representative, Owner

select * from customers where contacttitle in('Sales Representative','Owner')

--8 Retrieve orders placed between January 1, 2013, and December 31, 2013.

select * from orders where orderdate between '2013-01-01' and '2013-12-31';

--9 List all products whose category_id is not 1, 2, or 3.
select * from products where categoryid not in(1,2,3)

--10 Find customers whose company name starts with "A".

select * from customers where customername like 'A%'



--Question 4: Fetching/limit

--1  Retrieve the first 10 orders from the orders table.
select * from orders order by orderid limit 10;

--2  Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).

select * from orders order by orderid offset 10 limit 10;

--Question 5: --1 insert statement


-- Task: Add a new order to the orders table with the following details:
--Order ID: 11078
--Customer ID: ALFKI
--Employee ID: 5
--Order Date: 2025-04-23
--Required Date: 2025-04-30
--Shipped Date: 2025-04-25
--shipperID:2
--Freight: 45.50


insert into orders(orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight) values
(11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);
select * from orders where customerid='ALFKI'


