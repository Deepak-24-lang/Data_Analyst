PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Day8_OrderLines;
DROP TABLE IF EXISTS Day8_Orders;
DROP TABLE IF EXISTS Day8_Products;
DROP TABLE IF EXISTS Day8_Customers;

CREATE TABLE Day8_Customers (
    Customer_ID TEXT PRIMARY KEY,
    Customer_Name TEXT,
    Segment TEXT
);

CREATE TABLE Day8_Orders (
    Order_ID TEXT PRIMARY KEY,
    Customer_ID TEXT,
    Order_Date TEXT,
    Ship_Date TEXT,
    Ship_Mode TEXT,
    Region TEXT,
    FOREIGN KEY (Customer_ID)
        REFERENCES Day8_Customers(Customer_ID)
);

CREATE TABLE Day8_Products (
    Product_ID TEXT PRIMARY KEY,
    Product_Name TEXT,
    Category TEXT,
    Sub_Category TEXT
);

CREATE TABLE Day8_OrderLines (
    Row_ID INTEGER PRIMARY KEY,
    Order_ID TEXT,
    Product_ID TEXT,
    Sales REAL,
    Quantity INTEGER,
    Discount REAL,
    Profit REAL,
    FOREIGN KEY (Order_ID)
        REFERENCES Day8_Orders(Order_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES Day8_Products(Product_ID)
);

INSERT INTO Day8_Customers
    (Customer_ID, Customer_Name, Segment)
SELECT DISTINCT
    "Customer ID",
    "Customer Name",
    Segment
FROM Superstore;

INSERT INTO Day8_Orders
    (Order_ID, Customer_ID, Order_Date, Ship_Date, Ship_Mode, Region)
SELECT DISTINCT
    "Order ID",
    "Customer ID",
    "Order Date",
    "Ship Date",
    "Ship Mode",
    Region
FROM Superstore;

INSERT INTO Day8_Products
    (Product_ID, Product_Name, Category, Sub_Category)

SELECT
    "Product ID",
    MAX("Product Name"),
    MAX(Category),
    MAX("Sub-Category")

FROM Superstore

GROUP BY "Product ID";

INSERT INTO Day8_OrderLines
    (Row_ID, Order_ID, Product_ID, Sales, Quantity, Discount, Profit)
SELECT
    "Row ID",
    "Order ID",
    "Product ID",
    Sales,
    Quantity,
    Discount,
    Profit
FROM Superstore;

-->Query 1: Check customer count
SELECT count(*) as Total_Customer
from Day8_Customers;

-->Query 2: Check order count
SELECT COUNT(*) AS total_order
from Day8_Orders;

-->Query 3: Check product count
SELECT count(*) as total_product
from Day8_Products;

-->Check order-line count
SELECT count(*) as order_line_count
from Day8_OrderLines;

-->Query 5: Compare original and new order-line rows
SELECT
    (SELECT COUNT(*) FROM Superstore) AS Original_Rows,
    (SELECT COUNT(*) FROM Day8_OrderLines) AS New_OrderLine_Rows;
	

--inner JOIN	
-->Which customers placed orders, and what are their order IDs?
SELECT
    o.Order_ID,
    o.Customer_ID,
    c.Customer_Name,
    c.Segment,
    o.Region
FROM Day8_Orders AS o
INNER JOIN Day8_Customers AS c
    ON o.Customer_ID = c.Customer_ID
LIMIT 20;

-->Which customers bought which products, and how much profit did each product line generate?
SELECT
    o.Order_ID,
    c.Customer_Name,
    p.Product_Name,
    p.Category,
    ol.Sales,
    ol.Profit
FROM Day8_Orders AS o
INNER JOIN Day8_Customers AS c
    ON o.Customer_ID = c.Customer_ID
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
INNER JOIN Day8_Products AS p
    ON ol.Product_ID = p.Product_ID
LIMIT 25;

-->left JOIN
-->Which customers in our customer list have placed orders, and which have never ordered?
SELECT
    c.Customer_ID,
    c.Customer_Name,
    o.Order_ID
FROM Day8_Customers AS c
LEFT JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
ORDER BY c.Customer_Name;	

-->-7.3 Find customers with zero orders
SELECT c.Customer_ID,
c.Customer_Name,
c.Segment
from Day8_Customers as c
LEFT JOIN Day8_Orders as o
on c.Customer_ID = o.Customer_ID
where o.Order_ID is NULL;

SELECT COUNT(*) AS Customers_Without_Orders
FROM Day8_Customers AS c
LEFT JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;

-->What products were included in each order, and how much revenue was generated?
SELECT
    o.Order_ID,
    o.Order_Date,
    o.Region,
    ol.Product_ID,
    ol.Sales,
    ol.Quantity,
    ol.Profit
FROM Day8_Orders AS o
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
LIMIT 30;

-->Which customers generate the highest sales?
SELECT
    c.Customer_ID,
    c.Customer_Name,
    SUM(ol.Sales) AS Total_Sales
FROM Day8_Customers AS c
INNER JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-->Total profit by category
SELECT
    p.Category,
    SUM(ol.Sales) AS Total_Sales,
    SUM(ol.Profit) AS Total_Profit,
    ROUND(
        SUM(ol.Profit) * 100.0 / SUM(ol.Sales),
        2
    ) AS Profit_Margin_Percent
FROM Day8_Products AS p
INNER JOIN Day8_OrderLines AS ol
    ON p.Product_ID = ol.Product_ID
GROUP BY p.Category
ORDER BY Total_Profit DESC;

-->Sales by customer segment
SELECT
    c.Segment,
    COUNT(DISTINCT c.Customer_ID) AS Total_Customers,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(ol.Sales) AS Total_Sales,
    SUM(ol.Profit) AS Total_Profit
FROM Day8_Customers AS c
INNER JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;

-->Task 1 — Top 10 customers by revenue
-->Question: Who are our top 10 revenue-generating customers?
SELECT
    c.Customer_Name,
    SUM(ol.Sales) AS Total_Sales
FROM Day8_Customers AS c
INNER JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Total_Sales DESC
LIMIT 10;

-->Task 2 — Revenue by region
-->Question: Which region generates the most revenue?
SELECT
    o.Region,
    SUM(ol.Sales) AS Total_Sales,
    SUM(ol.Profit) AS Total_Profit
FROM Day8_Orders AS o
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
GROUP BY o.Region
ORDER BY Total_Sales DESC;

-->Task 3 — Product category performance
-->Question: Which product category has the highest profit?
SELECT
    p.Category,
    SUM(ol.Sales) AS Total_Sales,
    SUM(ol.Profit) AS Total_Profit,
    SUM(ol.Quantity) AS Total_Quantity
FROM Day8_Products AS p
INNER JOIN Day8_OrderLines AS ol
    ON p.Product_ID = ol.Product_ID
GROUP BY p.Category
ORDER BY Total_Profit DESC;

-->Task 4 — Customers with the most orders
-->Question: Who places orders most frequently?
SELECT
    c.Customer_Name,
    COUNT(DISTINCT o.Order_ID) AS Order_Count,
    SUM(ol.Sales) AS Total_Sales
FROM Day8_Customers AS c
INNER JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Order_Count DESC
LIMIT 10;

-->Task 5 — Products with no sales
-->Question: Are there any products in the product table that never appear in OrderLines?
SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category
FROM Day8_Products AS p
LEFT JOIN Day8_OrderLines AS ol
    ON p.Product_ID = ol.Product_ID
WHERE ol.Product_ID IS NULL;

-->Task 6 — Customers by segment and region
-->Question: Which segments generate the most sales in each region?
SELECT
    c.Segment,
    o.Region,
    COUNT(DISTINCT c.Customer_ID) AS Total_Customers,
    SUM(ol.Sales) AS Total_Sales,
    SUM(ol.Profit) AS Total_Profit
FROM Day8_Customers AS c
INNER JOIN Day8_Orders AS o
    ON c.Customer_ID = o.Customer_ID
INNER JOIN Day8_OrderLines AS ol
    ON o.Order_ID = ol.Order_ID
GROUP BY
    c.Segment,
    o.Region
ORDER BY
    o.Region,
    Total_Sales DESC;
	

