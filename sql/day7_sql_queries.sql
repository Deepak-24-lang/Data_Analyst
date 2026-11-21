-->DISTINCT (Find unique values)
-->Find all unique regions
SELECT DISTINCT Region
from Superstore;

-->Find unique categories
SELECT DISTINCT Category
from Superstore;

-->Find unique ship modes
SELECT DISTINCT "ship mode"
from Superstore;

-->Find unique combinations
SELECT DISTINCT Region,Category
from Superstore
order by Region,Category;

-->Write queries to find unique:
- Segments
- States
- Cities
- Sub-Categories
- Ship Mode and Region combinations

select DISTINCT Segment
from Superstore;

SELECT DISTINCT State
from Superstore;

SELECT DISTINCT City
from Superstore;

select DISTINCT "sub Category"
from Superstore;

SELECT DISTINCT "ship mode" ,Region
from Superstore
order by "ship mode",Region;

-->IN (Filter multiple values)
-->Filter multiple regions
SELECT * 
from Superstore
where Region in ('West','East','Central');

-->Filter multiple categories
SELECT * 
from Superstore
where Category in ('Technology','Furniture');

-->Combine IN with other conditions
select "order ID",region,Category,Sales,Profit
from Superstore
where Region='West'
and Category in ('Tehnology','Furniture')
order by Sales desc;

-->Use NOT IN
SELECT *
from Superstore
where Category not in ('Technology');

-->BETWEEN (Filter a range)
SELECT "order ID",Sales
from Superstore
where Sales BETWEEN 100 and 500;

-->Profit range
select "product Name",profit 
from Superstore
where Profit BETWEEN 50 and 200;

-->Quantity range
select * from Superstore
where Quantity BETWEEN 5 and 10;

-->Combine BETWEEN and other filters
select "order id",Region,Sales,Profit
from Superstore
where Region='West'
and Sales BETWEEN 100 and 200
order by sales desc;

-->LIKE (Search text patterns)
-->Products containing a word
SELECT "product name" ,sales ,Profit
from Superstore
where "product name" like '%Chair%';

-->Products starting with a word
SELECT
    "Product Name",
    Sales
FROM Superstore
WHERE "Product Name" LIKE 'Office%';

-->Search customer names
SELECT DISTINCT "Customer Name"
FROM Superstore
WHERE "Customer Name" LIKE '%Smith%';

-->Search for a single character wildcard
select *
from Superstore
where "product name" like 'B_';

-->NULL handling
-->Find missing values
select * from Superstore
where "postal code" is null;

-->Find records where Postal Code exists
select * from Superstore
where "postal code" is not null;

-->Count missing Postal Codes
SELECT 
count(*) as total_records,
count("postal code") as non_missing_postal_code,
count(*)-count("Postal code") as Missing_postal_code

-->Analyze missing data by region
SELECT
    Region,
    COUNT(*) AS Total_Records,
    COUNT("Postal Code") AS Available_Postal_Codes,
    COUNT(*) - COUNT("Postal Code") AS Missing_Postal_Codes
FROM Superstore
GROUP BY Region
ORDER BY Missing_Postal_Codes DESC;

from Superstore;

-->Products ending with a word
SELECT
    "Product Name",
    Sales
FROM Superstore
WHERE "Product Name" LIKE '%Table';

-->CASE WHEN (Create business categories)
-->Example 1 — Categorize Profit
Imagine the business wants to classify each record as:
- Profitable
- Loss
- Break-even

select "order ID",
sales ,profit,
CASE
	when Profit>0 then 'Profitable'
	when profit<0 then 'Loss'
	else 'Break-even'
end as profit_status
from Superstore
LIMIT 10;

-->Example 2 — Categorize Sales
Create sales bands:
- High Sales: 1,000 or more
- Medium Sales: 250 to less than 1,000
- Low Sales: less than 250
SELECT "order id",
sales,
CASE
	when Sales >=1000 then 'High Sales'
	when sales >=250 then 'Medium Sales'
	else 'Low Sales'
	end as Sales_Band
from Superstore
limit 10;

-->Categorize Discount levels
select Discount,
CASE
	when Discount=0 then 'No Discount'
	when Discount<0.25 then 'lOW Discount'
	when Discount<0.50 then 'High Discount'
	ELSE 'Very High Discount'
end as Discount_Band
from Superstore;

-->Count records in each Profit Status
SELECT
    CASE
        WHEN Profit > 0 THEN 'Profitable'
        WHEN Profit < 0 THEN 'Loss'
        ELSE 'Break-even'
    END AS Profit_Status,
    COUNT(*) AS Record_Count,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Superstore
GROUP BY Profit_Status
ORDER BY Total_Profit DESC;

-->Example 5 — Sales band performance
SELECT 
	CASE 
		when sales >=1000 then 'High Sales'
		when sales >=250 then 'Medium Sales'
		else 'Low Sales'
		end as Sales_Band,
	count(*) as Total_records,
	count(sales) as Total_sales,
	count(profit) as Total_profit
from Superstore
group by Sales_band
order by Total_sales Desc;

-->Date filtering in SQLite
WITH first_split AS (
    SELECT *,
        substr("Order Date", 1, instr("Order Date", '/') - 1) AS month_txt,
        substr("Order Date", instr("Order Date", '/') + 1) AS remaining_date
    FROM Superstore
),
second_split AS (
    SELECT *,
        substr(remaining_date, 1, instr(remaining_date, '/') - 1) AS day_txt,
        substr(remaining_date, instr(remaining_date, '/') + 1) AS year_txt
    FROM first_split
),
normalized AS (
    SELECT *,
        printf(
            '%04d-%02d-%02d',
            CAST(year_txt AS INTEGER),
            CAST(month_txt AS INTEGER),
            CAST(day_txt AS INTEGER)
        ) AS iso_order_date
    FROM second_split
)
SELECT
    "Order ID",
    "Order Date",
    iso_order_date,
    Sales,
    Profit
FROM normalized
WHERE iso_order_date BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY iso_order_date;

select "order date" from Superstore;
SELECT *
FROM Superstore
WHERE date("Order Date") BETWEEN '2017-01-01' AND '2017-12-31';

WITH first_split AS (
    SELECT *,
        substr("Order Date", 1, instr("Order Date", '/') - 1) AS month_txt,
        substr("Order Date", instr("Order Date", '/') + 1) AS remaining_date
    FROM Superstore
),
second_split AS (
    SELECT *,
        substr(remaining_date, 1, instr(remaining_date, '/') - 1) AS day_txt,
        substr(remaining_date, instr(remaining_date, '/') + 1) AS year_txt
    FROM first_split
),
normalized AS (
    SELECT *,
        printf(
            '%04d-%02d-%02d',
            CAST(year_txt AS INTEGER),
            CAST(month_txt AS INTEGER),
            CAST(day_txt AS INTEGER)
        ) AS iso_order_date
    FROM second_split
)
SELECT
    SUM(Sales) AS Sales_2017,
    SUM(Profit) AS Profit_2017,
    COUNT(*) AS Records_2017
FROM normalized
WHERE iso_order_date BETWEEN '2017-01-01' AND '2017-12-31';
	
	
