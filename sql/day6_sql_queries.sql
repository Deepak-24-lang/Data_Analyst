
-->SELECT and FROM : 
select * from Superstore
limit 5;

select "Order ID","Order Date",Sales,Profit from Superstore
limit 10;

select Region , Category ,Sales,Profit from Superstore
LIMIT 10;

SELECT
    "Order Date",
    Region,
    "Sub-Category",
    Sales
FROM Superstore
LIMIT 20

-->WHERE (Filtering data)
SELECT * from Superstore
WHERE Region='West';

select * from Superstore
where Category='Technology';

-->Combine conditions
select * from Superstore
WHERE Region='West'
AND Category = 'Technology';

-->Use OR
SELECT * FROM Superstore
WHERE Region='West'
or Region='Central';

SELECT * FROM Superstore
WHERE Profit>0;

SELECT * from Superstore
WHERE Profit<0;

1. All records where Category = Furniture.
SELECT * from Superstore
where Category='Furniture';

2. All records where Segment = Consumer.
select * from Superstore
where Segment='Consumer';

3.All records where Sales are greater than 500.
SELECT * FROM Superstore
WHERE Sales>500;

4.All records where Profit is negative.
SELECT * from Superstore
where Profit<0;

5.All records where Region = South and Ship Mode = First Class.
SELECT * from Superstore
WHERE Region='South' 
AND "Ship Mode"='First Class';

-->ORDER BY (Sorting data)
SELECT "order ID",Sales,Region from Superstore
order by Sales DESC
LIMIT 10;

SELECT "product name",Sales,Profit from Superstore
order by Profit DESC
limit 10;

SELECT Sales from Superstore
order by Sales DESC
limit 10;

SELECT Sales from Superstore
order by sales ASC
limit 10;

select Profit from Superstore
order by Profit DESC
limit 10;

select profit from Superstore
order by profit ASC
limit 10;

SELECT "order ID",Sales,Region from Superstore
order by Sales ASC
LIMIT 10;

-->Aggregate functions
SELECT sum(Sales) as total_sales
from Superstore;

SELECT sum(Profit) as total_profit 
from Superstore;

SELECT avg(sales) as Average_Sales 
from Superstore;

SELECT avg(Discount) as Average_discount 
from Superstore;

SELECT count(*) as Total_Records 
from Superstore;

SELECT sum(sales) as total_sales,
sum(Profit) as total_profit,
avg(sales) as average_sales,
avg(Discount) as average_discount,
count(*) as total_count
from Superstore

-->GROUP BY
How much sales revenue did each region generate?
select Region,sum(sales) as total_sales
from Superstore
group by Region
order by Sales DESC;

Which product category generates the most profit?
select Category,sum(profit) as total_profit
from Superstore
group by Category
order by total_profit DESC;

-->Sales and Profit by Segment
SELECT Segment,sum(sales) as total_sales,sum(profit) as total_profit
from Superstore
GROUP by Segment
order by total_sales DESC;

-->Sales by Region and Category
SELECT
    Region,
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Region, Category
ORDER BY Region, Total_Sales DESC;

-->HAVING
Regions with sales above $500,000
select Region,
sum(sales) as total_sales
from Superstore
GROUP by Region
HAVING total_sales>500000;

Categories with negative total profit

Select * from Superstore;
select Category,sum(Profit) as total_profit
from Superstore
group by Category
HAVING profit<0;

Sub-categories with losses
select "Sub Category",sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by "Sub Category"
HAVING total_profit<0
order by total_profit Asc;

select * from Superstore;
Which region has the highest sales?
select Region,sum(sales) as total_sales
from Superstore
group by Region
order by total_sales desc;

Which category is the most profitable?
select Category,sum(profit) as total_profit
from Superstore
GROUP by Category
order by total_profit Desc;

Find Technology sales in the West region
SELECT
    "Order ID",
    "Product Name",
    Sales,
    Profit,
    Region,
    Category
FROM Superstore
WHERE Region = 'West'
AND Category = 'Technology'
ORDER BY Sales DESC;

Top 10 products by sales
select "Product Name",
sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by "product Name"
order by sales DESC
limit 10;

Top 10 products by profit
select "product Name" ,
sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by "product Name"
order by profit DESC
limit 10;

Find loss-making sub-categories
select "sub Category",
sum(sales) as total_sales,
sum(profit) as total_profit
from Superstore
group by "Sub Category"
having sum(sales)<0
order by total_profit ASC;	







