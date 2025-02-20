create table customer(
  CustomerID int Primary Key,
  CustomerName varchar(50),
  Email varchar(100),
  Country varchar(50),
  SignupDate Date
);

create table Products(
	ProductID int primary key,
	ProductName varchar(50),
	Category varchar(50),
	Price int,
	StockQuantity int
);

create table Orders(
	OrderID int primary key,
	CustomerID int,
	OrderDate Date,
	TotalAmount int,
	Status varchar(50),
	FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID)
);

create table OrderDetails(
	OrderDetailID int primary key,
	OrderID  int,
	ProductID int,
	Quantity int,
	Price int,
	Foreign key (OrderID) REFERENCES Orders(OrderID),
	Foreign key (ProductID) REFERENCES Products(ProductID)
);

create table Payments(
	PaymentID int primary key,
	OrderID int,
	PaymentDate Date,
	PaymentMethod varchar(50),
	Amount int
);

INSERT INTO customer (CustomerID, CustomerName, Email, Country, SignupDate) VALUES
(1, 'John Doe', 'mailto:john@example.com', 'USA', '2023-01-01'),
(2, 'Jane Smith', 'mailto:jane@example.com', 'Canada', '2023-02-15'),
(3, 'Robert Johnson', 'mailto:robert@example.com', 'UK', '2023-03-20'),
(4, 'Emily Davis', 'mailto:emily@example.com', 'Australia', '2023-04-10'),
(5, 'Michael Brown', 'mailto:michael@example.com', 'Germany', '2023-05-05'),
(6, 'Sophia Wilson', 'mailto:sophia@example.com', 'France', '2023-06-18'),
(7, 'William Taylor', 'mailto:william@example.com', 'Italy', '2023-07-22'),
(8, 'Olivia Martinez', 'mailto:olivia@example.com', 'Spain', '2023-08-30'),
(9, 'James Anderson', 'mailto:james@example.com', 'India', '2023-09-12'),
(10, 'Isabella Thomas', 'mailto:isabella@example.com', 'Mexico', '2023-10-25'),
(11, 'Ethan Jackson', 'mailto:ethan@example.com', 'Japan', '2023-11-07'),
(12, 'Mia White', 'mailto:mia@example.com', 'South Korea', '2023-12-14'),
(13, 'Benjamin Harris', 'mailto:benjamin@example.com', 'Brazil', '2024-01-20'),
(14, 'Charlotte Lewis', 'mailto:charlotte@example.com', 'China', '2024-02-10'),
(15, 'Daniel Walker', 'mailto:daniel@example.com', 'Russia', '2024-03-05'),
(16, 'Ava Young', 'mailto:ava@example.com', 'UAE', '2024-04-18'),
(17, 'Henry Hall', 'mailto:henry@example.com', 'South Africa', '2024-05-22'),
(18, 'Ella Allen', 'mailto:ella@example.com', 'Netherlands', '2024-06-30'),
(19, 'Logan Scott', 'mailto:logan@example.com', 'Sweden', '2024-07-15'),
(20, 'Grace King', 'mailto:grace@example.com', 'Norway', '2024-08-05');

INSERT INTO Products (ProductID, ProductName, Category, Price, StockQuantity) VALUES
(1, 'Laptop', 'Electronics', 1000, 50),
(2, 'Smartphone', 'Electronics', 700, 100),
(3, 'Headphones', 'Accessories', 150, 200),
(4, 'Desk Chair', 'Furniture', 300, 75),
(5, 'Gaming Console', 'Entertainment', 500, 30),
(6, 'Coffee Maker', 'Appliances', 120, 40),
(7, 'Tablet', 'Electronics', 400, 80),
(8, 'Backpack', 'Fashion', 80, 150),
(9, 'Smartwatch', 'Accessories', 250, 90),
(10, 'Printer', 'Office Supplies', 200, 60);
select * from Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status) VALUES
(111, 1, '2024-01-15', 1700, 'Shipped'),
(211, 2, '2024-01-16', 150, 'Delivered'),
(31, 3, '2024-01-17', 400, 'Pending'),
(41, 4, '2024-01-21', 800, 'Shipped'),
(51, 5, '2024-01-27', 1200, 'Delivered'),
(61, 6, '2024-02-23', 500, 'Cancelled'),
(71, 7, '2024-02-26', 1000, 'Pending'),
(81, 8, '2024-02-18', 300, 'Shipped'),
(91, 9, '2024-02-18', 1500, 'Delivered'),
(101, 10, '2024-02-23', 2200, 'Pending'),
(121, 12, '2024-03-17', 600, 'Delivered'),
(131, 13, '2024-03-18', 400, 'Pending'),
(141, 14, '2024-03-19', 900, 'Cancelled'),
(151, 15, '2024-03-27', 300, 'Delivered'),
(161, 16, '2024-04-28', 1300, 'Pending'),
(171, 17, '2024-04-29', 1800, 'Shipped'),
(181, 18, '2024-04-30', 200, 'Cancelled'),
(191, 19, '2024-04-29', 250, 'Delivered'),
(201, 20, '2024-04-29', 1100, 'Shipped'),
(221, 2, '2024-05-20', 1400, 'Delivered'),
(231, 3, '2024-05-25', 750, 'Shipped'),
(241, 4, '2024-05-30', 600, 'Pending'),
(251, 5, '2024-05-30', 1300, 'Shipped'),
(261, 6, '2024-05-30', 150, 'Delivered'),
(271, 7, '2024-05-30', 2000, 'Shipped'),
(281, 8, '2024-06-30', 400, 'Cancelled'),
(291, 9, '2024-06-30', 500, 'Shipped'),
(301, 10, '2024-06-30', 2200, 'Delivered');

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount, Status) VALUES
(1, 1, '2024-01-10', 1700, 'Shipped'),
(2, 2, '2024-01-12', 150, 'Delivered'),
(3, 3, '2024-01-15', 400, 'Pending'),
(4, 4, '2024-01-20', 800, 'Shipped'),
(5, 5, '2024-01-25', 1200, 'Delivered'),
(6, 6, '2024-02-01', 500, 'Cancelled'),
(7, 7, '2024-02-05', 1000, 'Pending'),
(8, 8, '2024-02-10', 300, 'Shipped'),
(9, 9, '2024-02-15', 1500, 'Delivered'),
(10, 10, '2024-02-20', 2200, 'Pending'),
(11, 11, '2024-03-01', 700, 'Shipped'),
(12, 12, '2024-03-05', 600, 'Delivered'),
(13, 13, '2024-03-10', 400, 'Pending'),
(14, 14, '2024-03-15', 900, 'Cancelled'),
(15, 15, '2024-03-20', 300, 'Delivered'),
(16, 16, '2024-04-01', 1300, 'Pending'),
(17, 17, '2024-04-05', 1800, 'Shipped'),
(18, 18, '2024-04-10', 200, 'Cancelled'),
(19, 19, '2024-04-15', 250, 'Delivered'),
(20, 20, '2024-04-20', 1100, 'Shipped'),
(21, 1, '2024-04-25', 500, 'Pending'),
(22, 2, '2024-05-01', 1400, 'Delivered'),
(23, 3, '2024-05-05', 750, 'Shipped'),
(24, 4, '2024-05-10', 600, 'Pending'),
(25, 5, '2024-05-15', 1300, 'Shipped'),
(26, 6, '2024-05-20', 150, 'Delivered'),
(27, 7, '2024-05-25', 2000, 'Shipped'),
(28, 8, '2024-06-01', 400, 'Cancelled'),
(29, 9, '2024-06-05', 500, 'Shipped'),
(30, 10, '2024-06-10', 2200, 'Delivered');


INSERT INTO Payments (PaymentID, OrderID, PaymentDate, PaymentMethod, Amount) VALUES
(1, 1, '2024-01-11', 'Credit Card', 1700),
(2, 2, '2024-01-13', 'PayPal', 150),
(3, 3, '2024-01-16', 'Debit Card', 400),
(4, 4, '2024-01-21', 'Credit Card', 800),
(5, 5, '2024-01-26', 'Bank Transfer', 1200),
(6, 7, '2024-02-06', 'PayPal', 1000),
(7, 8, '2024-02-11', 'Credit Card', 300),
(8, 9, '2024-02-16', 'Debit Card', 1500),
(9, 10, '2024-02-21', 'Bank Transfer', 2200),
(10, 11, '2024-03-02', 'Credit Card', 700),
(11, 12, '2024-03-06', 'PayPal', 600),
(12, 13, '2024-03-11', 'Debit Card', 400),
(13, 15, '2024-03-21', 'Credit Card', 300),
(14, 16, '2024-04-02', 'PayPal', 1300),
(15, 17, '2024-04-06', 'Bank Transfer', 1800),
(16, 19, '2024-04-16', 'Credit Card', 250),
(17, 20, '2024-04-21', 'PayPal', 1100),
(18, 21, '2024-04-26', 'Debit Card', 500),
(19, 22, '2024-05-02', 'Credit Card', 1400),
(20, 23, '2024-05-06', 'PayPal', 750),
(21, 24, '2024-05-11', 'Bank Transfer', 600),
(22, 25, '2024-05-16', 'Debit Card', 1300),
(23, 26, '2024-05-21', 'Credit Card', 150),
(24, 27, '2024-05-26', 'PayPal', 2000),
(25, 29, '2024-06-06', 'Debit Card', 500),
(26, 30, '2024-06-11', 'Bank Transfer', 2200);


select * from payments
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 1000),
(2, 1, 2, 1, 700),
(3, 2, 3, 1, 150),
(4, 3, 4, 1, 300),
(5, 3, 7, 1, 400),
(6, 4, 5, 1, 500),
(7, 4, 6, 1, 120),
(8, 5, 7, 1, 400),
(9, 5, 8, 1, 80),
(10, 6, 9, 1, 250),
(11, 7, 10, 1, 200),
(12, 8, 1, 1, 1000),
(13, 9, 2, 1, 700),
(14, 10, 3, 1, 150),
(15, 11, 4, 1, 300),
(16, 12, 5, 1, 500),
(17, 13, 6, 1, 120),
(18, 14, 7, 1, 400),
(19, 15, 8, 1, 80),
(20, 16, 9, 1, 250),
(21, 17, 10, 1, 200),
(22, 18, 1, 1, 1000),
(23, 19, 2, 1, 700),
(24, 20, 3, 1, 150),
(25, 21, 4, 1, 300),
(26, 22, 5, 1, 500),
(27, 23, 6, 1, 120),
(28, 24, 7, 1, 400),
(29, 25, 8, 1, 80),
(30, 26, 9, 1, 250);


-- 1. Query: Total Sales Per Product Category
--Find the total revenue generated for each product category.
select pr.Category as totalRevenue,sum(pr.Price*pr.StockQuantity) from Products as pr join OrderDetails as od
on pr.ProductID = od.ProductID join Orders as ord on od.OrderID = ord.OrderID
where ord.status = 'Delivered'
group by pr.Category;

-- 2. Query: Top 5 Customers by Total Spending
-- Identify the top 5 customers who have spent the most on delivered orders.
select  cu.CustomerID, cu.CustomerName,sum(Price*Quantity) from Customer cu join Orders ord on(cu.CustomerID=ord.CustomerID) join OrderDetails od on(ord.OrderID = od.OrderID)
group by cu.CustomerID order by CustomerID
FETCH FIRST 5 ROWS WITH TIES;

-- 3. Query: Monthly Sales Growth Rate
-- Compute the month-over-month sales growth percentage.


	





-- 4. Query: Average Order Value (AOV) Per Customer
-- Find the average amount spent per order by each customer

select cu.customerID,cu.customerName,avg(ord.TotalAmount) as AverageOrderValue from customer cu join Orders ord
on cu.CustomerID = ord.CustomerID
join OrderDetails od
on ord.OrderID = od.OrderID 
group by cu.customerID order by cu.customerID;

-- 5. Query: Products with Low Stock
-- Identify products where the stock quantity is below a given threshold
select pr.productID , pr.ProductName, sum(pr.StockQuantity) from Products pr 
left join OrderDetails od on  pr.ProductID = od.ProductID
left join Orders ord on od.orderID = ord.orderID where status='Delivered'
group by pr.productID;


--. Query: Most Frequently Purchased Products
--Find the top 10 most frequently ordered products
select  pr.productID,pr.productName,sum(od.quantity) as totalPurchase from orderdetails od join products pr on od.productID = pr.productID
join orders ord on od.orderId =ord.orderID where status = 'Delivered' group by pr.productID order by totalPurchase Desc Limit 10;


-- 7. Query: Customer Retention Analysis
-- Calculate the percentage of customers who placed another order within 90 days of their 
-- first order.
with FirstOrder as(
 SELECT CustomerID, MIN(OrderDate) AS FirstPurchaseDate
    FROM Orders
    GROUP BY CustomerID
),
RepeatOrder as(
	select ord.CustomerID,ord.OrderDate from FirstOrder fo join orders ord
	on fo.customerID=ord.customerID
	and ord.OrderDate > fo.FirstPurchaseDate 
	AND ord.OrderDate <= fo.FirstPurchaseDate + INTERVAL '90 days'
)
select 100*(count(Distinct(ro.customerId))/count(Distinct(fd.customerID)))
from FirstOrder fd  join  RepeatOrder ro 
on fd.customerID= ro.customerID;

-- 8). Query: Revenue Contribution of Each Payment Method
-- Determine the percentage of total revenue generated by each payment method

select (100*sum(amount)/(select sum(amount) from payments)) as totalRevenuePersentage  from payments group by paymentmethod

--9)  Query: Order Processing Time Analysis
-- Find the average time taken for an order to move from ‘Pending’ to ‘Delivered’ status.

with DeliveredOrders as(
    select OrderID, OrderDate, 
           (select OrderDate from Orders where OrderID = ord.OrderID and Status = 'Delivered') as DeliveredDate
    from Orders ord
)
select ROUND(avg(DeliveredDate - OrderDate), 2) as AvgProcessingTime
from DeliveredOrders
where DeliveredDate is not null;


-- 10. Query: Repeat Customer Rate
-- Calculate the percentage of customers who have made more than one purchase

SELECT 
    ROUND(100.0 * count(distinct CustomerID) filter (where OrderCount > 1) / count(distinct CustomerID), 2) as RepeatCustomerRate
from (
    select CustomerID, count(OrderID) as OrderCount
    from Orders
    where Status = 'Delivered'
    group by CustomerID
) as CustomerOrders;