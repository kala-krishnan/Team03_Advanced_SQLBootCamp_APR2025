--1. Create Table Employees with Constraints
create table employees (
	employeeId Integer primary key,
	employeeName Text not Null,
	title text not Null,
	city text,
	country text,
	reportsTo Integer,
	constraint fk_reports_to
	foreign key (reportsTo)
	references employees(employeeId)
	on delete set null
	);
	
	COPY employees 
	FROM '/Users/krishna/Downloads/archive/employees.csv' 
	WITH (FORMAT csv, HEADER true);
	
	select * from employees;
	
	--2. Create Table Categories with Constraints
	
	create table categories (
	categoryId Integer primary key,
		categoryName Text not null,
		description Text
	);
	
	COPY categories 
	FROM '/Users/krishna/Downloads/archive/categories.csv' 
	WITH (FORMAT csv, HEADER true);
	
	select * from categories;
		
	--3. Create Table customers with Constraints
	
	create table customers (
	customerId char(5) primary key,
	customerName Text not Null,
	contactName Text,
	contacttitle text,
	city text,
	country text
	);
	
	COPY customers 
	FROM '/Users/krishna/Downloads/archive/customers.csv' 
	WITH (FORMAT csv, HEADER true, ENCODING 'LATIN1');
	
	select * from customers;
	
		
--4. Create Table Shippers with Constraints
	create table shippers (
	shipperID Integer primary key,
	companyName Text not Null
	);
	
	COPY shippers 
	FROM '/Users/krishna/Downloads/archive/shippers.csv' 
	WITH (FORMAT csv, HEADER true, ENCODING 'LATIN1');
	
	
	--5 create table orders with constraints
	
	create table orders (
	orderID Integer primary key,
	customerID char(5),
	employeeID Integer,
	orderDate date,
	requiredDate date,
	shippedDate date,
	shipperID Integer,
	freight numeric(10,2),
	constraint fk_customer_Id 
	foreign key (customerID) references customers(customerID)
	on delete cascade,
	constraint fk_employee_Id
	foreign key (employeeId) references employees(employeeId)
	on delete set null,
	constraint fk_shipper_ID 
	foreign key (shipperID) references shippers(shipperID)
	on delete set null
	);
	
	COPY orders 
	FROM '/Users/krishna/Downloads/archive/orders.csv' 
	WITH (FORMAT csv, HEADER true, ENCODING 'LATIN1');
	
	select * from orders;
	
	--6 create table products with constraints
	
	create table products (
	productID Integer primary key,
	productName text not null,
	quantityPerUnit text not null,
	unitPrice numeric(10,2),
	discontinued integer check (discontinued in (0,1)),
	categoryId integer,
	constraint fk_category_Id 
	foreign key (categoryId) references categories(categoryId)
	on delete set null
	);
	
	COPY products 
	FROM '/Users/krishna/Downloads/archive/products.csv' 
	WITH (FORMAT csv, HEADER true, ENCODING 'LATIN1');
	
	
	select * from products;
	
	--7 create table order_details with constraints
	
	create table order_details (
	orderID Integer,
	productId Integer,
	unitPrice numeric(10,2) not null,
	quantity integer not null check (quantity >0),
	discount numeric(3,2) check (discount >=0 and discount <=1),
	PRIMARY KEY (orderID, productId),
	foreign key (orderID) references orders(orderID) on delete cascade,
	foreign key (productId) references products(productId) on delete cascade
	);
	
	COPY order_details 
	FROM '/Users/krishna/Downloads/archive/order_details.csv' 
	WITH (FORMAT csv, HEADER true, ENCODING 'LATIN1');
	
	
	select * from order_details;
	
	
	