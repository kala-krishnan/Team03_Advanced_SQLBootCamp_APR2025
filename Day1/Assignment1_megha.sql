
create table categories(
categoryID serial primary key ,
categoryName varchar(200),
description varchar(200)
)
select * from categories;

create table customers(
customerID varchar(30) primary key,
companyName text,
contactName text,
contactTitle text,
city text,
country text
);
--COPY customers(customerID, companyName, contactName, contactTitle, city, country)
--FROM 'C:/Users/sreer/Downloads/Megha DA163/sql/BOOTCAMP/customers.csv'
--DELIMITER ','
--CSV HEADER
--ENCODING 'LATIN1';
select*
from customers

create table employees(
employeeID serial primary key,
employeeName text,
title text,
city text,
country text,
reportsTo text
)
select*
from employees

create table order_details(
orderID int,
productID int,
unitPrice float,
quantity int,
discount float
)
select *
from order_details

create table orders(
orderID int,
customerID text,
employeeID integer,
orderDate date,
requiredDate date,
shippedDate date,
shipperID integer,
freight real
)
alter table orders
add constraint pk_orders primary key (orderID)--to make order id the primary key
select *
from orders

create table products(
productID real primary key,
productName text,
quantityPerUnit text,
unitPrice real,
discontinued boolean,
categoryID real
) 
select*
from products

create table shippers(
shipperID text,
companyName text
)
alter table shippers
add constraint pk_shippers primary key(shipperID)
select *
from shippers

CREATE TABLE datadictionary (
     "Table" VARCHAR(100),
     Field VARCHAR(100),
     Description VARCHAR(100)
 );
 
 select * from datadictionary