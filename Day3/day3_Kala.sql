--1)Update the categoryName From “Beverages” to "Drinks" in the categories table.
select * from categories

update categories
set categoryname = 'Drinks'
where categoryname='Beverages'
--------------------------------------*****************------------------------------------------------
--2)Insert into shipper new record (give any values)
--Delete that new record from shippers table.

select * from shippers;
insert into shippers(shipperid,companyname) values
(4,'Fedex');
delete from shippers where shipperid=4

--------------------------------------*****************------------------------------------------------

--3 Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 --Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 --(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
--******. Alter table by dropping already existing constraints*******
alter table products drop constraint if exists fk_category_Id
 
 --********* add cascade constraints
 alter table products add constraint fk_product_category
 	foreign key (categoryId) references categories(categoryId)
	on delete cascade
	on update cascade;
	
	update categories
	set categoryid=1001
	where categoryid=1;
	select * from categories where categoryid=1001;
	 select * from products where categoryid=1001;
	 
	 delete from categories where categoryid=3
	 select * from categories where categoryid=3;
	 select * from products where categoryid=3;
	 select * from order_details
	
--------------------------------------*****************------------------------------------------------
 
-- 4)Delete the customer = “VINET”  from customers. 
--Corresponding customers in orders table should be set to null
--(HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)

--******. Alter table by dropping already existing constraints*******
alter table orders drop constraint if exists fk_customer_Id;

--  *************Alter table constraints by adding cascade**************
alter table orders
add constraint fk_orders_customerId
foreign key (customerid) references customers(customerid)
on delete set null

delete from customers where customerid='VINET'

select * from customers where customerid='VINET'
select * from orders  where customerid is null

--------------------------------------*****************------------------------------------------------

--5)      Insert the following data to Products using UPSERT:
--product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
--product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
--product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
--(this should update the quantityperunit for product_id = 100)

select * from products where productid=100;
	
	insert into products(productid,productname,quantityperunit,unitprice,discontinued,categoryid)
	values(100,'Whole Wheat bread',1,13,0,5),(101,'Refined Flour White bread','5 boxes',13,0,5)
	ON CONFLICT (productid)
DO UPDATE SET
productname=EXCLUDED.productname,
quantityperunit=EXCLUDED.quantityperunit,
unitprice=EXCLUDED.unitprice,
discontinued=EXCLUDED.discontinued,
categoryid=EXCLUDED.categoryid;

--6)      Write a MERGE query:

create temp table updated_products
(productID Integer primary key,
	productName text not null,
	quantityPerUnit text not null,
	unitPrice numeric(10,2),
	discontinued integer check (discontinued in (0,1)),
	categoryId integer);
	
	categoryId integer,
	constraint fk_category_Id 
	foreign key (categoryId) references categories(categoryId)
	on delete set null
	
	alter table updated_products
	add constraint fk_category_Id 
	foreign key (categoryId) references categories(categoryId)
	on delete set null
	
	insert into updated_products
	values(100,'Wheat bread',10,20,1,5),(101,'White bread','5 boxes',19.99,0,5),(102,'Midnight Mango Fizz','24-12oz bottles',19,0,1),
	(103,'Savory Fire Sauce','12-550ml bottles',10,0,2);
	
	select * from updated_products;
	
	merge into products as p
	using updated_products as up
	on p.productid=up.productid
	when matched and up.discontinued=0 THEN
	update set unitprice = up.unitprice,
	discontinued=up.discontinued
	when matched and up.discontinued=1 then
	delete
	when not matched and up.discontinued=0 then 
	insert (productid,productname,quantityperunit,unitprice,discontinued,categoryid) 
	values(up.productid,up.productname,up.quantityperunit,up.unitprice,up.discontinued,up.categoryid);
	
	--7)      List all orders with employee full names. (Inner join)

select order1.order_id,employees.first_name||employees.last_name as Employee_FullName 
from orders order1 inner join employees employees2 ON employees2.employee_id = order1.employee_id;

