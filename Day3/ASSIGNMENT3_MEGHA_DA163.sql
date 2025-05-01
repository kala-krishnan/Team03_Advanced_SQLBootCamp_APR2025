------------ASSIGNMENT 3--------------
---1)      Update the categoryName From “Beverages” to "Drinks" in the categories table.

UPDATE public.categories
SET category_name = 'Drinks'
WHERE category_name = 'Beverages';

SELECT *
FROM public.categories

--2)      Insert into shipper new record (give any values) Delete that new record from shippers table.
SELECT *
FROM public.shippers

INSERT INTO public.shippers(shipper_id,company_name,phone)
VALUES (123,'NEW_NAME',5678)

DELETE FROM public.shippers
WHERE shipper_id=123

--3)      Update categoryID=1 to categoryID=1001. Make sure related products update their categoryID too. Display the both category and products table to show the cascade.
 --Delete the categoryID= “3”  from categories. Verify that the corresponding records are deleted automatically from products.
 --(HINT: Alter the foreign key on products(categoryID) to add ON UPDATE CASCADE, ON DELETE CASCADE)
 SELECT *
 FROM public.products, public.categories
 
ALTER TABLE products
DROP CONSTRAINT IF EXISTS fk_products_categories

ALTER TABLE products
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (category_id) REFERENCES categories(category_id)
ON UPDATE CASCADE 
 ON DELETE CASCADE

ALTER TABLE public.order_details
DROP CONSTRAINT IF EXISTS fk_order_details_products

ALTER TABLE public.order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY(Product_id)
REFERENCES Products(Product_id)
ON UPDATE CASCADE 
 ON DELETE CASCADE
 

UPDATE public.categories
SET category_id=1001
WHERE category_id=1;

SELECT *
FROM public.categories
ORDER BY category_id


DELETE FROM public.categories
WHERE category_id=3             

--4)      Delete the customer = “VINET”  from customers. Corresponding customers in orders table should be set to null (HINT: Alter the foreign key on orders(customerID) to use ON DELETE SET NULL)
SELECT *
FROM public.customers
--F_KEY PROB WITH ORDERS, SO USE CASCADE
ALTER TABLE public.orders
DROP CONSTRAINT IF EXISTS fk_orders_customers

ALTER TABLE public.orders
ADD CONSTRAINT fk_orders_customers
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON UPDATE CASCADE 
 ON DELETE CASCADE

ALTER TABLE public.order_details
DROP CONSTRAINT IF EXISTS fk_order_details_orders

ALTER TABLE public.order_details
ADD CONSTRAINT fk_order_details_orders
FOREIGN KEY(order_id)
REFERENCES orders(order_id)
ON UPDATE CASCADE 
 ON DELETE CASCADE

DELETE FROM public.customers
WHERE customer_id='VINET'
------------------------------------------------------------------------------------------
---5)      Insert the following data to Products using UPSERT:
product_id = 100, product_name = Wheat bread, quantityperunit=1,unitprice = 13, discontinued = 0, categoryID=5
product_id = 101, product_name = White bread, quantityperunit=5 boxes,unitprice = 13, discontinued = 0, categoryID=5
product_id = 100, product_name = Wheat bread, quantityperunit=10 boxes,unitprice = 13, discontinued = 0, categoryID=5
(this should update the quantityperunit for product_id = 100)

--QUERY:
SELECT * FROM Products WHERE product_id in (100,101)

INSERT INTO products(product_id, product_name, quantity_per_unit,
unit_price, discontinued, category_id)
VALUES(100,'Wheat bread' , 1, 13, 0, 5)
ON CONFLICT(product_id)
DO UPDATE
SET product_name = Excluded.product_name,
quantity_per_unit = Excluded.quantity_per_unit,
unit_price = Excluded.unit_price,
discontinued = Excluded.discontinued,
category_id = Excluded.category_id;

INSERT INTO products(product_id, product_name, quantity_per_unit,
unit_price, discontinued, category_id)
VALUES(101,'Wheat bread' , 5, 13, 0, 5)
ON CONFLICT(product_id)
DO UPDATE
SET product_name = Excluded.product_name,
quantity_per_unit = Excluded.quantity_per_unit,
unit_price = Excluded.unit_price,
discontinued = Excluded.discontinued,
category_id = Excluded.category_id;

INSERT INTO products(product_id, product_name, quantity_per_unit,
unit_price, discontinued, category_id)
VALUES(100,'Wheat bread' , 10, 13, 0, 5)
ON CONFLICT(product_id)
DO UPDATE
SET product_name = Excluded.product_name,
quantity_per_unit = Excluded.quantity_per_unit,
unit_price = Excluded.unit_price,
discontinued = Excluded.discontinued,
category_id = Excluded.category_id;

-------------------------------------------------------------------------------------------------
--6)      Write a MERGE query:
--Create temp table with name:  ‘updated_products’ and insert values as below

MERGE INTO products AS P
USING(
   VALUES
   (100, 'Wheat bread', '10', 20, 1, 5),
   (101, 'White bread', '5 boxes', 19.99, 0, 5),
   (102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 0, 1001),
   (103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 0, 2)
)AS Updated_products(product_id, product_name, quantity_per_unit, unit_price, discontinued, category_id)
ON P.product_id = Updated_products.product_id

WHEN MATCHED AND  Updated_products.discontinued = 1 THEN
DELETE
WHEN MATCHED AND  Updated_products.discontinued = 0 THEN
UPDATE SET
   product_name = Updated_products.product_name,
  unit_price = Updated_products.unit_price
WHEN NOT MATCHED AND  Updated_products.discontinued = 0 THEN
   INSERT(product_id, product_name, quantity_per_unit,
unit_price, discontinued, category_id)
   VALUES (Updated_products.product_id, Updated_products.product_name, Updated_products.quantity_per_unit,
Updated_products.unit_price, Updated_products.discontinued, Updated_products.category_id)

SELECT * FROM Products WHERE product_id IN (100, 101, 102, 103)



---------------------------------------------------------


CREATE TEMP TABLE updated_products (
    productid INT,
    productname TEXT,
    quantityperunit TEXT,
    unitprice NUMERIC,
    discontinued BOOLEAN,
    categoryid INT
);

INSERT INTO updated_products (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES
(100, 'Wheat bread', '10', 20, 'TRUE', 3),
(101, 'White bread', '5 boxes', 19.99, 'FALSE', 3),
(102, 'Midnight Mango Fizz', '24 - 12 oz bottles', 19, 'FALSE', 1001),
(103, 'Savory Fire Sauce', '12 - 550 ml bottles', 10, 'FALSE', 2);

TRUNCATE updated_products; 
DELETE FROM updated_products;
SELECT * FROM updated_products;
SELECT * FROM categories;

-- Step 2: 
MERGE INTO products p
USING updated_products u
ON p.productid = u.productid
WHEN MATCHED AND u.discontinued = 'FALSE' THEN
UPDATE SET 
        unitprice = u.unitprice,
        discontinued = u.discontinued
WHEN MATCHED AND u.discontinued = 'TRUE' THEN
DELETE
WHEN NOT MATCHED AND u.discontinued = 'FALSE' THEN
INSERT (productid, productname, quantityperunit, unitprice, discontinued, categoryid)
VALUES (u.productid, u.productname, u.quantityperunit, u.unitprice, u.discontinued, u.categoryid);



SELECT * FROM products;

