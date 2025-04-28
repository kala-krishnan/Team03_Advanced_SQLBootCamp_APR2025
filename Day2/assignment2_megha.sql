------ASSIGNMENT 2---
--1)      Alter Table:

--Add a new column linkedin_profile to employees table to store LinkedIn URLs as varchar.
 alter table employees
 add column LinkedIn_URL varchar(100) unique

 select*
 from employees
--Change the linkedin_profile column data type from VARCHAR to TEXT. 
alter table employees
alter column LinkedIn_URL
set data type  text;

--Add unique, not null constraint to linkedin_profile
UPDATE employees
 SET linkedin_URL = 'linkedin.com/'||employeename

alter table employees
alter column LinkedIn_URL
set not null,
add constraint constraint_name UNIQUE (LinkedIn_URL)


--Drop column linkedin_profile
alter table employees
drop column LinkedIn_URL

-------------------------------------------------------------------------------------------------------------
--2)Querying (Select)
 --Retrieve the first name, last name, and title of all employees
 select employeename, title
 from employees
 
 --Find all unique unit prices of products
 select distinct unitprice
 from public.products
 order by unitprice

-- List all customers sorted by company name in ascending order
select companyname, contactname as customers
from public.customers
order by companyname asc

 --Display product name and unit price, but rename the unit_price column as price_in_usd
alter table products
rename column unitprice to price_in_usd
select productname,price_in_usd
from products

-------------------------------------------------------------------------------------------------------------------------
--3) Filtering
--Get all customers from Germany.
select contactname as customers, country
from public.customers
where country ='Germany'

--Find all customers from France or Spain
select contactname as customers, country
from public.customers
where country in( 'Germany','France','Spain')
order by country

--Retrieve all orders placed in 1997 (based on order_date), and either have freight greater than 50 or
--the shipped date available (i.e., non-NULL)  (Hint: EXTRACT(YEAR FROM order_date))
select orderid, EXTRACT(YEAR FROM orderdate) AS order_year,freight,shippeddate
from orders
where-- order_year=1997 and
 freight>50 or shippeddate is not null
-------------------------------------------------------------------------------------------------------------------
--4)  Filtering
 --Retrieve the product_id, product_name, and unit_price of products where the unit_price is greater than 15.
select productid,
productname,(price_in_usd )as unitprice
from public.products
where price_in_usd>15
order by price_in_usd;

--List all employees who are located in the USA and have the title "Sales Representative".
select employeename,title ,country
from public.employees
where country='USA' and title='Sales Representative'

--Retrieve all products that are not discontinued and priced greater than 30.
select productname,price_in_usd,discontinued
from public.products
where discontinued= 'false' and price_in_usd>30

---------------------------------------------------------------------------------------------------------------
--5) LIMIT/FETCH
 --Retrieve the first 10 orders from the orders table.
 select *
 from public.orders
 limit 10
 
 --Retrieve orders starting from the 11th order, fetching 10 rows (i.e., fetch rows 11-20).
select *
 from public.orders
 limit 10
 offset 10

 ------------------------------------------------------------------------------------------------------
 --6)      Filtering (IN, BETWEEN)

--List all customers who are either Sales Representative, Owner
select contactname as customers,contacttitle
from public.customers
where contacttitle in ('Sales Representative', 'Owner')
order by contacttitle

--Retrieve orders placed between January 1, 2013, and December 31, 2013.
select orderid,orderdate
from public.orders
where orderdate between '2013-01-01' and '2013-12-31'

----------------------------------------------------------------------------------------------------
--7)      Filtering
--List all products whose category_id is not 1, 2, or 3.
select productname, categoryid
from public.products
where categoryid not in (1,2,3)
order by categoryid

--Find customers whose company name starts with "A".
select contactname as customers,companyname
from public.customers
where companyname like'A%'

 -----------------------------------------------------------------------------------------------
 --8) INSERT into orders table:
Task: Add a new order to the orders table with the following details:
Order ID: 11078
Customer ID: ALFKI
Employee ID: 5
Order Date: 2025-04-23

Required Date: 2025-04-30
Shipped Date: 2025-04-25
shipperID:2
Freight: 45.50

insert into public.orders(
orderid,customerid,employeeid,orderdate,requireddate,shippeddate,shipperid,freight)
values (11078,'ALFKI',5,'2025-04-23','2025-04-30','2025-04-25',2,45.50);

 select *
 from public.orders
 --------------------------------------------------------------------------------------------
 --9)      Increase(Update)  the unit price of all products in category_id =2 by 10%.--
--(HINT: unit_price =unit_price * 1.10)
 update public.products
 set price_in_usd= price_in_usd * 1.10
where categoryid=2

select *
from public.products
where categoryid=2
-------------------------------------------------------------------------------------------------
--10) Sample Northwind database:
Download
 Download northwind.sql from below link into your local. Sign in to Git first https://github.com/pthom/northwind_psql
 Manually Create the database using pgAdmin:
 Right-click on "Databases" → Create → Database
Give name as ‘northwind’ (all small letters)
Click ‘Save’

Import database:
 Open pgAdmin and connect to your server          	
  Select the database  ‘northwind’
  Right Click-> Query tool.
  Click the folder icon to open your northwind.sql file
 Press F5 or click the Execute button.
  You will see total 14 tables loaded
  Databases → your database → Schemas → public → Tables
 


