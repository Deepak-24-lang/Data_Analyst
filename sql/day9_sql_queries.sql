SELECT name
FROM sqlite_master
WHERE type = 'table'
ORDER BY name;

PRAGMA table_info(Superstore);

SELECT *
FROM Superstore
LIMIT 10;

SELECT COUNT(*) AS Total_Rows
FROM Superstore;

-->Query 1: Key performance indicators
SELECT
    COUNT(*) AS Total_Order_Lines,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    COUNT(DISTINCT "Customer ID") AS Total_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    ROUND(AVG(Discount), 2) AS Average_Discount
FROM Superstore;

-->Overall profit margin
SELECT
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percent
FROM Superstore;

-->The Sales Manager asks:
“Which region generates the most sales, and which region generates the most profit?”

Query 3: Sales and profit by region
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percent
FROM Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-->Query 4: Identify loss-making regions
SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Region
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-->Query 5: Performance by category
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percent
FROM Superstore
GROUP BY Category
ORDER BY Total_Profit DESC;

--.Query 6: Performance by sub-category
SELECT
    Category,
    "Sub-Category",
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore
GROUP BY
    Category,
    "Sub-Category"
ORDER BY Total_Profit ASC;

-->Query 7: Top 10 products by sales
SELECT
    "Product ID",
    "Product Name",
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore
GROUP BY
    "Product ID",
    "Product Name"
ORDER BY Total_Sales DESC
LIMIT 10;

-->Query 8: Bottom 10 products by profit
SELECT
    "Product ID",
    "Product Name",
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore
GROUP BY
    "Product ID",
    "Product Name"
ORDER BY Total_Profit ASC
LIMIT 10;

-->The manager asks:
“Which customer segment contributes the most to our business?”

Query 9: Segment performan
SELECT
    Segment,
    COUNT(DISTINCT "Customer ID") AS Total_Customers,
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percent
FROM Superstore
GROUP BY Segment
ORDER BY Total_Sales DESC;

-->Query 10: Top 10 customers by sales
SELECT
    "Customer ID",
    "Customer Name",
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore
GROUP BY
    "Customer ID",
    "Customer Name"
ORDER BY Total_Sales DESC
LIMIT 10;

-->Query 11: Customers with negative total profit
SELECT
    "Customer ID",
    "Customer Name",
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore
GROUP BY
    "Customer ID",
    "Customer Name"
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

-->A business may offer discounts to increase sales. But excessive discounts can reduce profit.

The manager asks:
“Are higher discounts associated with lower profitability?”

Query 12: Profit by discount band

SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.20 THEN 'Low Discount'
        WHEN Discount <= 0.40 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS Discount_Band,
    COUNT(*) AS Order_Lines,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS Profit_Margin_Percent
FROM Superstore
GROUP BY Discount_Band
ORDER BY Total_Profit DESC;

-->The manager asks:
“How do shipping modes relate to sales and profitability?”

Query 14: Sales by ship mode

SELECT
    "Ship Mode",
    COUNT(DISTINCT "Order ID") AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(AVG(Discount), 2) AS Average_Discount
FROM Superstore
GROUP BY "Ship Mode"
ORDER BY Total_Sales DESC;
